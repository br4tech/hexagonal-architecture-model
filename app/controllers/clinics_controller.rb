# frozen_string_literal: true

class ClinicsController < ApplicationController
  before_action :set_office
  before_action :set_clinic, only: %i[show edit update destroy clinic_attendances]

  def show
    @clinic = Clinic.find(params[:id])
  end

  def new
    @clinic = Clinic.new
  end

  def create
    @clinic = @office.clinics.build(clinic_params)
    respond_to do |format|
      if @clinic.save
        format.html { redirect_to @office, notice: 'Sala cadastrada com sucesso.' }
        format.json { render json: @clinic, status: :created, location: @office, message: 'Sala cadastrada com sucesso' }
      else
        format.html { redirect_to @office }
        format.json { render json: @clinic.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    @clinic = @office.clinics.find(params[:id])
    respond_to do |format|
      if @clinic.update(clinic_params)
        format.html { redirect_to @office, notice: 'Dados da Sala atualizados.' }
        format.json { render json: @clinic, status: :ok, location: @office, message: 'Sala cadastrada com sucesso' }
      else
        format.html { redirect_to @office }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @clinic.attendances.blank?
      @clinic.destroy
      respond_to do |format|
        format.html { redirect_to @office, notice: 'Sala removida.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @office, alert: 'Sala não pode ser removida, pois possui atendimentos agendados' }
        format.json { head :no_content }
      end
    end
  end

  def clinic_attendances
    render json: @clinic.reservations
  end

  private

  def set_clinic
    @clinic = Clinic.find(params[:id])
  end

  def set_office
    @office = Office.find(params[:office_id])
  end

  def clinic_params
    params.require(:clinic).permit(:code, :price, :metrics, :medical_specialties, :color)
  end
end
