class UsersController < ApplicationController
  def create
    user = User.new(name: params[:name], email: params[:email])
    user = user_repository.create(name: user.name, email: user.email)
    render json: user, status: :created
  end

  def show
    user = user_repository.find(params[:id])
    render json: user
  end

  private

  def user_repository
    @user_repository ||= Persistence::UserRepository.new
  end
end