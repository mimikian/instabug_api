class Api::V1::BugsController < ApplicationController

  before_action :extract_app_token
  before_action :bug_exist, only: :show
  skip_before_action :verify_authenticity_token
  respond_to :json

  api :GET, "/bugs", "Get the bugs related to a specific application"
  def index
    @bugs = Bug.search(params, @app_token)
  end

  api :GET, "/users/:id", "Get a bug using it's number and the application token is stored as a header 'Application-Token'"
  def show
    @state = @bug.state
  end

  api :POST, "/bugs", "Create a bug"
  def create
    params = bug_params
    @bug = Bug.new(params)
    @bug.application_token = @app_token
    @bug.auto_increment_number
    if @bug.valid?
      params[:number] = @bug.number
      params[:application_token] = @app_token
      # Insert to a RabbitMQ worker
      Publisher.publish("bugs", params)
      render 'create', status: 201
    else
      render json: { errors: @bug.errors }, status: 422
    end
  end

  api :GET, "/bugs", "Get the count of bugs related to a specific application"
  def count
    count = Bug.cached_count(@app_token)
    render json: { count: count }
  end

  private

  def bug_params
    params.require(:bug).permit(:number, :status, :priority, :comment, state_attributes: [:device, :os, :memory, :storage])
  end

  def extract_app_token
    @app_token = request.headers["Application-Token"]
  end

  def bug_exist
    number = params[:id]
    @bug = Bug.cached_vesrion(@app_token, number)
    if @bug.nil?
      render json: { errors: "404 Not found" }, status: 404
    end
  end
end
