# frozen_string_literal: true

class ContractsController < ApplicationController  
  before_action :set_client, only: %i[index new edit]
  before_action :set_contract, only: %i[edit update]

  # GET /contracts
  # GET /contracts.jsonf
  def index
    @contracts = ContractCombo.includes(:client).page(params[:page]).per(50).order('clients.name')
  end

  # GET /contracts/new
  def new
    @kind = PersonKind.all
    @contract = Contract.new
    @contract.client = Client.new
  end

  # GET /contracts/1/edit
  def edit; end

  def show; end

  # POST /contracts
  # POST /contracts.json
  def create
    @kind = PersonKind.all
    @service = ContractService.new(contract_params)  
    @service.create    
    @contract = @service.contract    
  
    respond_to do |format|
      if @contract.save
        ScheduleWorker.new.perform(@contract.id)
        format.html { redirect_to combo_client_path(@contract.client_id, @contract.contract_combo, Company.categories.keys[@contract.category || 0]), notice: 'Contrato cadastrado com sucesso.' }
        format.json { render json: @contract, status: :created, location: @contract, message: 'Contrato cadastrado com sucesso' }
      else        
        format.html { render :new }
        format.json { render json: @contract.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update  
    @kind = PersonKind.all
    @service = ContractService.new(contract_params, params[:id])    
    @service.update
    @contract = @service.contract

    respond_to do |format|
      if @contract.valid?
        ScheduleWorker.new.perform(@contract.id)
        format.html { redirect_to combo_client_path(@contract.client_id, @contract.contract_combo, Company.categories.keys[@contract.category || 0]), notice: 'Contrato atualizado.' }
        format.json { render :show, status: :ok, location: @contract }     
      else              
        format.html { render :show }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contrato removido.' }
      format.json { head :no_content }
    end
  end

  private
  
  # Use callbacks to shparamsare common setup or constraints between actions.
  def set_contract
    @contract = Contract.find(params[:id])
  end

  def set_client
    return if params[:client_id].nil?    
    @client = Client.find(params[:client_id])  
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def contract_params
    params.require(:contract)
      .permit(:id, :contract_combo_id, :client_id, :category, :starts_at, :ends_at, :amount, :revenues_at, :due_at, :forfeit, :kind, :rescheduling_allowed, :parking, :parking_value, :car_license_plate,   
        client_attributes: [:id, :name, :email, :kind, :document, :zipcode, :street, :number, :complement, :neighborhood, :city, :state,
           doctors_attributes: [:id, :name, :email, :crm, :document, :phone, :_destroy]
          ],        
          discounts_attributes:     [:id, :amount, :starts_at, :ends_at, :_destroy],
          attendances_attributes:   [:id, :office_id, :clinic_id, :frequency, :starts_at, :ends_at, :time_starts, :time_ends, :is_recurrent, :_destroy, weekdays: []])
  end
end