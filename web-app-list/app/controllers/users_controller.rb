class UsersController < ApplicationController

  def show
    user = user_repository.find(params[:id])
    render json: user
  end
end