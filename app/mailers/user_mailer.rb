# frozen_string_literal: true

# Mailer
class UserMailer < ApplicationMailer
  def welcome
    @user = params[:user]
    @token = params[:token]
    mail(to: @user.email, subject: 'Aqui está seu acesso a plataforma da Pronto Consultórios')
  end
end
