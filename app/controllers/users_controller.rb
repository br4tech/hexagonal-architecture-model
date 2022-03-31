# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  # before_action :authorize_user

  def index
    @users = User.page(params[:page]).per(7)
  end

  def new
    @user = User.new
    @user.offices = Office.all
  end

  def show
    Office.where.not(id: @user.accesses.pluck(:office_id)).each do |office|
      @user.accesses.build(office_id: office.id)
    end
  end

  def create
    @user = User.new(user_params)
    @user.password = Devise.friendly_token

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Usuário cadastrado com sucesso.' }
        format.json { render json: @user, status: :created, location: @user, message: 'Usuário cadastrado com sucesso' }
      else
        format.html { render :new }
        format.json { render json: @user.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        path = (@user.id == current_user.id ? profile_path : @user)
        format.html { redirect_to path, notice: 'Dados atualizados.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :show }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Usuário removido.' }
      format.json { head :no_content }
    end
  end

  def profile
    @user = current_user
  end

  def update_password
    @user = current_user

    if @user.update_with_password(user_pass_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to profile_path, notice: 'Senha Atualizada'
    else
      redirect_to profile_path, alert: @user.errors.full_messages.first
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :document, :phone, :email, :role, :status, :avatar, accesses_attributes: %i[id office_id allow])
  end

  def user_pass_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
