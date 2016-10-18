class Api::V1::BugsController < ApplicationController
  respond_to :json

  def show
    respond_with Bug.find(params[:id])
  end
end
