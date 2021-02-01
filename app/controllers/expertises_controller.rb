# frozen_string_literal: true

class ExpertisesController < ApplicationController
  def index
    if params[:query].present?
      render json: Expertise.where('LOWER(name) LIKE ?', "%#{params[:query].downcase}%")
    else
      render json: Expertise.all
    end
  end
end
