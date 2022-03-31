# frozen_string_literal: true

class OfficesController < ApplicationController
  before_action :set_office, only: %i[show edit update destroy office_schedule]

  # GET /offices
  # GET /offices.json
  def index
    @offices = Office.all
    @office = Office.new
  end

  # GET /offices/1
  # GET /offices/1.json
  def show; end

  # GET /offices/1/edit
  def edit; end

  def new
    @office = Office.new
  end

  # POST /offices
  # POST /offices.json
  def create
    @office = Office.new(office_params)

    respond_to do |format|
      if @office.save
        format.html { redirect_to @office, notice: 'Unidade criada.' }
        format.json { render :show, status: :created, location: @office }
      else
        format.html { render :new }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offices/1
  # PATCH/PUT /offices/1.json
  def update
    respond_to do |format|
      if @office.update(office_params)
        format.html { redirect_to @office, notice: 'Unidade atualizada.' }
        format.json { render :show, status: :ok, location: @office }
      else
        format.html { render :edit }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @office.clinics.blank?
      @office.destroy
      respond_to do |format|
        format.html { redirect_to @office, notice: 'Unidade removida.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @office, alert: 'Unidade não pode ser removida, pois possui sala(s) cadastrada(s)' }
        format.json { head :no_content }
      end
    end
  end

  def office_schedule
    render json: @office.clinics
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_office
    @office = Office.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def office_params
    params.require(:office).permit(:name, :code, :address, :phone, :phone_secondary, :start_at, :end_at, weekdays: [])
  end
end
