# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :title

  include Pundit
  protect_from_forgery with: :exception

  layout :define_layout

  def title
    @title ||= TITLES[controller_name.to_sym] if TITLES.keys.include?(controller_name.to_sym)
  end

  private

  def define_layout
    devise_controller? ? 'auth' : 'application'
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  TITLES = {
    main: 'Agendamentos',
    doctors: 'Clientes',
    offices: 'Unidades',
    users: 'Usuários',
    contracts: 'Contratos'
  }.freeze

  private_constant :TITLES

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    redirect_to root_path
  end
end
