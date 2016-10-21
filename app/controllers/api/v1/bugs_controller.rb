class Api::V1::BugsController < ApplicationController

  before_action :extract_app_token
  before_action :bug_exist, only: :show
  skip_before_action :verify_authenticity_token
  respond_to :json

  def index
    @bugs = Bug.search(params, @app_token)
    # render json: bugs, include: :state
  end

  def show
    @state = State.find_by(bug_id: @bug.id)
    # render json: @bug, include: :state
  end

  def create
    bug = Bug.new(bug_params)
    bug.application_token = @app_token
    bug.auto_increment_number
    if bug.valid?
      # Insert to a RabbitMQ worker
      Publisher.publish("bugs", bug.attributes)
      render json: bug, include: :state, status: 201
    else
      render json: { errors: bug.errors }, status: 422
    end
  end

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
