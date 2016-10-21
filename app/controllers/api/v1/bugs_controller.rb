class Api::V1::BugsController < ApplicationController

  before_action :bug_exist, only: :show
  before_action :extract_app_token
  skip_before_action :verify_authenticity_token
  respond_to :json

  def index
    bugs = Bug.search(params, @app_token)
    render json: bugs, include: :state
  end

  def show
    render json: @bug, include: :state
  end

  def create
    bug = Bug.new(bug_params)
    bug.application_token = @app_token
    bug_save = bug.save
    if bug_save
      render json: bug, include: :state, status: 201, location: api_v1_bug_path(bug)
    else
      render json: { errors: bug.errors }, status: 422
    end
  end

  def count
    count = Bug.where(application_token: @app_token).count
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
    @bug = Bug.find_by(application_token: @app_token, number: number)
    if @bug.nil?
      render json: { errors: "404 Not found" }, status: 404
    end
  end
end
