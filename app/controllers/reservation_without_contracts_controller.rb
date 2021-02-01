class ReservationWithoutContractsController < ApplicationController
  before_action :set_reservation_without_contract, only: [:show, :edit, :update, :destroy]

  def index
    @office =  session[:office_id].blank? ? current_user.offices.first: Office.find(session[:office_id])   
    @reservations_without_contract = ReservationWithoutContract.where('office_id= ? AND date BETWEEN ? AND ?', @office.id, params[:start], params[:end])
  end

  def show
  end

  def new
    @kind = PersonKind.all
    @reservation_without_contract = ReservationWithoutContract.new 
    @reservation_without_contract.client = Client.new    
  end

  def edit;end

  def create
    @service = ReservationWithoutContractService.new(reservation_without_contract_params)  
    @service.create 
    @reservation_without_contract = @service.reservation_without_contract
        
    respond_to do |format|
      if @reservation_without_contract.save
        format.html { redirect_to root_path, notice: 'Reserva cadastrado com sucesso.' }
        format.json { render json: :new, status: :created, location:  @reservation_without_contract, message: 'Reserva cadastrado com sucesso' }
      else    
        format.json { render json:  @reservation_without_contract.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update      
    @service = ReservationWithoutContractService.new(reservation_without_contract_params)  
    @service.update
    @reservation_without_contract = @service.reservation_without_contract

    respond_to do |format|
      if   @reservation_without_contract.valid?
        format.html { redirect_to root_path, notice: 'Reserva atualizada com sucesso.' }
        format.json { render json: :edit, status: :created, location:  @reservation_without_contract, message: 'Reserva cadastrado com sucesso' }
      else    
        format.json { render json:  @reservation_without_contract.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reservation_without_contract.destroy
  end

  private
    def set_reservation_without_contract
      @kind = PersonKind.all
      @reservation_without_contract = ReservationWithoutContract.find(params[:id])
    end

    def reservation_without_contract_params
      params.require(:reservation_without_contract).permit(:id, :date, :office_id, :clinic_id, :start_at, :end_at,
       client_attributes:  [:name, :document, :email, :phone, :kind])
    end

end
