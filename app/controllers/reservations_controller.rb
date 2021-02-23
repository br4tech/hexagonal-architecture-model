class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def index 
    @office =  session[:office_id].nil? ? current_user.offices.first : Office.find(session[:office_id])
    @reservations = Reservation.includes([:clinic, contract: :client])
                               .where('office_id = ? AND canceled=false AND date BETWEEN ? AND ?',@office.id, params[:start], params[:end])
  end

  def show
  end

  def new
    @reservation = Reservation.new 
  end

  def edit;end

  def create
    @service  = ReservationService.new(reservation_params)
    @service.create
    @reservation = @service.reservation_pronto ||  @service.reservation_density
 
    respond_to do |format|
      if  @reservation.save
        format.html { redirect_to root_path, notice: 'Reserva cadastrado com sucesso.' }
        format.json { render json: :new, status: :created, location: @reservation, message: 'Reserva cadastrado com sucesso' }
      else    
        format.json { render json: @reservation.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update 
    @service = ReservationService.new(reservation_params)
    @service.update
    @reservation = @service.reservation_pronto
 
    respond_to do |format|
      if @reservation.valid?
        format.html { redirect_to root_path, notice: 'Reserva atualizada com sucesso.' }
        format.json { render json: :edit, status: :created, location: @reservation, message: 'Reserva cadastrado com sucesso' }
      else    
        format.json { render json: @reservation.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @service = ReservationService.new(@reservation)
    @service.destroy
    @reservation = @service.reservation

    respond_to do |format|   
      unless @reservation.errors.any?      
        format.html { redirect_to root_path, notice: 'Reserva removida com sucesso.' }   
        format.json { head :ok }    
      else  
        format.html { redirect_to root_path, :alert => "warning: #{@reservation.errors.full_messages}"}
        format.json { head :ok }        
      end
    end
  end

  def reservation_not_available
    hours_not_available = ReservationService.new(reservation_not_available_params)
    render json: hours_not_available.reservation_not_available 
  end

  def reservation_not_available_day    
    hours_not_available_day = ReservationService.new(reservation_not_available_day_params)
    render json: hours_not_available_day.reservation_not_available_day
  end

  private
    def set_reservation
      @reservation = Reservation.find(params[:id])    
    end

    def reservation_not_available_params
      params.permit(:office_id, :clinic_id, :start_at, :end_at, :time_start, :time_end, weekdays: [])
    end

    def reservation_not_available_day_params
      params.permit(:office_id, :clinic_id, :start_at)
    end

    def reservation_params
      params.require(:reservation).permit(:id, :contract_id, :date, :office_id, :clinic_id, :start_at, :end_at, :odd, :category)
    end

end
