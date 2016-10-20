class Api::V1::BugsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def show
    app_token = request.headers["Application-Token"]
    number = params[:id]
    bug =  Bug.find_by(application_token: app_token, number: number)
    render json: bug, include: :state
  end

  def create
    app_token = request.headers["Application-Token"]
    bug = Bug.new(bug_params)
    bug.application_token = app_token
    bug_save = bug.save
    if bug_save
      render json: bug, include: :state, status: 201, location: api_v1_bug_path(bug)
    else
      render json: { errors: bug.errors }, status: 422
    end
  end

  private

  def bug_params
    params.require(:bug).permit(:number, :status, :priority, :comment, state_attributes: [:device, :os, :memory, :storage])
  end
end
