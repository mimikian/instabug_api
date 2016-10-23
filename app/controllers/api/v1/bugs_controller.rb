class Api::V1::BugsController < ApplicationController

  before_action :bug_exist, only: :show
  respond_to :json

  api :GET, "/bugs", "Get the bugs related to a specific application Example: curl -H \"Application-Token:b78f8f2319c2b95d79954\" #{ENV['SERVER_IP']}/api/bugs"
  def index
    @bugs = Bug.search(params, @app_token)
  end

  api :GET, "/bugs/:number", "Get a bug using it's number and the application token is stored as a header 'Application-Token' Example: curl -H \"Application-Token:b78f8f2319c2b95d79954\" #{ENV['SERVER_IP']}/api/bugs/1"
  def show
    @state = @bug.state
  end

  api :POST, "/bugs", "Create a bug Example: curl -i -X POST -H 'Content-Type:application/json' -H  'Application-Token: b78f8f2319c2b95d79954' #{ENV['SERVER_IP']}/api/bugs -d '{\"status\":\"new\",\"priority\":\"minor\",\"comment\":\"this is a comment\"}'"
  def create
    params = bug_params
    params[:status] = Bug.get_map_status_value(params[:status])
    @bug = Bug.new(params)
    @bug.application_token = @app_token
    @bug.auto_increment_number
    if @bug.valid?
      params[:number] = @bug.number
      params[:application_token] = @app_token
      # Insert to a RabbitMQ worker
      Publisher.publish("bugs", params)
      render json: { number: @bug.number }, status: 201
    else
      render json: { errors: @bug.errors }, status: 422
    end
  end

  api :GET, "/bugs", "Get the count of bugs related to a specific application, Example: curl -H \"Application-Token:b78f8f2319c2b95d79954\" #{ENV['SERVER_IP']}/api/bugs/count"
  def count
    count = Bug.cached_count(@app_token)
    render json: { count: count }
  end

  private
  def bug_params
    params.require(:bug).permit(:number, :status, :priority, :comment, state_attributes: [:device, :os, :memory, :storage])
  end

  def verify_authenticity_token
    @app_token = request.headers["Application-Token"]
    if @app_token.nil?
      render json: { errors: "Invalid application token" }
    end
  end

  def bug_exist
    number = params[:id]
    @bug = Bug.cached_vesrion(@app_token, number)
    if @bug.nil?
      render json: { errors: "404 Not found" }, status: 404
    end
  end
end
