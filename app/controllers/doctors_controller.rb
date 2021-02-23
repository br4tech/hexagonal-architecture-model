# frozen_string_literal: true

class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[show edit update destroy combo contract contracts info]

  # GET /doctors
  # GET /doctors.json
  def index
    @q = Doctor.ransack(params[:q])    
    @doctors =  @q.result(distinct: true).page(params[:page]).per(9)     
  end

  # GET /doctors/1
  # GET /doctors/1.json
  def show
    @doctor = Doctor.find(params[:id])
    @doctor.expertises.build if @doctor.expertises.empty? 
  end
  
  # GET /doctors/new
  def new
    @builder = DoctorBuilder.new(params)
    @doctor = @builder.doctor
  end

  # GET /doctors/1/edit
  def edit; end

  # POST /doctors
  # POST /doctors.json
  # def create   
  #   @builder = DoctorBuilder.new(params)
  #   @doctor = @builder.doctor

  #   respond_to do |format|
  #     if @doctor.save
  #       format.html { redirect_to @doctor, notice: 'Cliente cadastrado com sucesso.' }
  #       format.json { render json: @doctor, status: :created, location: @doctor, message: 'Cliente cadastrado com sucesso' }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @doctor.errors.full_messages, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /doctors/1
  # PATCH/PUT /doctors/1.json
  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        format.html { redirect_to params[:origin], notice: 'Medioco atualizado.' }
        format.json { render :show, status: :ok, location: @doctor }
      else
        format.html { render :show }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctors/1
  # DELETE /doctors/1.json
  def destroy
    @doctor.destroy
    respond_to do |format|
      format.html { redirect_to doctors_url, notice: 'Medico removido.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def doctor_params
    params.require(:doctor)
      .permit(:id, :name, :document, :crm, :phone, :email, :gender, :zipcode, :address, :number, :complement, :neighborhood, :city, :state, 
              expertises_attributes: [:id, :name, :duration, :price, :returns, :confirm, :days_to_return, :observations], 
              medical_info_attributes: [:id, :receipt_type, :pay_first, payment_methods: []])
  end
end