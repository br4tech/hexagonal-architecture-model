# frozen_string_literal: true

class ReservationService
  attr_reader :params
  attr_accessor :reservation_pronto, :reservation_density, :reservation

  def initialize(params)
    @params = params
  end

  def create
    Reservation.transaction do     
      build
      reservation_contract_type
      reservation_available
      commit
    end
  end

  def update
    Reservation.transaction do 
      rebuild  
      reservation_available       
      commit
    end
  end

  def destroy 
    Reservation.transaction do
      reservation_cancellation_rule     
    end
  end

  def build
    @reservation_density =  Reservation.new(params)
    @reservation_pronto =  Reservation.new(params)
  end

  def reservation_contract_type   
    contract = Contract.find(params[:contract_id])
    contracts = Contract.where(contract_combo_id: contract.contract_combo_id)

    contracts.each do |c|
      unless c.category == 1
        @reservation_pronto.contract_id = c.id
        @reservation_pronto.category = c.category      
      else
        @reservation_density.contract_id = c.id   
        @reservation_density.category = c.category  
      end
    end   
  end

  def reservation_available
    start_at = (@params["date"].to_s + ' ' + @params["start_at"].to_s).to_datetime.strftime("%Y-%m-%dT%H:%M:%S")
    end_at =  (@params["date"].to_s + ' ' + @params["end_at"].to_s).to_datetime.strftime("%Y-%m-%dT%H:%M:%S")
    
    reservations = ReservationAvailable.where(
      clinic_id: @params["clinic_id"], 
      start_at: start_at..end_at)      

    reservations.each do |reservation|
      if reservation.available 
          reservation.available = false             
      else     
        reservation.available = true       
      end  
      reservation.save
    end     
  end

  def reservation_cancellation_rule
     contract = Contract.find(params[:contract_id])   
     @reservation = Reservation.find(params[:id])    
      
     if @reservation.date > Date.today
      if contract.rescheduling_used < contract.rescheduling_allowed 
        reservation_change_available_status @reservation

        PayrollItem.delete_by(reservations_id: @reservation.id)
        Reservation.delete(@reservation.id)
        contract.rescheduling_used += 1 

        rescheduling_alowed = ReschedulingAllowed.create(client_id: contract.client.id, 
          available: contract.rescheduling_allowed, used: contract.rescheduling_used)

        rescheduling_alowed.save
        contract.save 
      else              
        @reservation.canceled = true
        @reservation.save
        @reservation.errors.add(:base, "Reserva cancelada, porém faturada")
      end     
    else
      @reservation.errors.add(:base, "Reserva não pode ser excluida: data atual > data da reserva")
    end
  end

  def reservation_change_available_status reservation  
    reservations_nonavailable = ReservationAvailable.where(start_at: reservation.start_at..reservation.end_at, 
      clinic_id: reservation.clinic_id, available: false)
      
      reservations_nonavailable.each do |r| 
        r.available = true       
        r.save
      end     
  end  
  
  def rebuild   
    reservation = Reservation.find(params[:id])

    reservations = Reservation.where(
      date:  reservation.date, 
      office_id: reservation.office_id, 
      clinic_id: reservation.clinic_id,
      start_at: reservation.start_at)

    reservations.each do |reservation|    
      unless reservation.category ==  1   

        reservation.date = params[:date]
        reservation.office_id = params[:office_id]
        reservation.clinic_id = params[:clinic_id]

        unless params[:start_at].nil? && params[:start_at].nil?
          reservation.start_at = (params[:date].to_s + ' ' + params[:start_at].to_s).to_datetime.strftime("%Y-%m-%dT%H:%M:%S")
          reservation.end_at =  (params[:date].to_s + ' ' + params[:end_at].to_s).to_datetime.strftime("%Y-%m-%dT%H:%M:%S")
        end 
        
        reservation_change_available_status reservation
        @reservation_pronto = reservation       
      else       
        reservation.date = params[:date]
        reservation.office_id = params[:office_id]
        reservation.clinic_id = params[:clinic_id]

        unless params[:start_at].nil? && params[:start_at].nil?
          reservation.start_at = (params[:date].to_s + ' ' + params[:start_at].to_s).to_datetime.strftime("%Y-%m-%dT%H:%M:%S")
          reservation.end_at =  (params[:date].to_s + ' ' + params[:end_at].to_s).to_datetime.strftime("%Y-%m-%dT%H:%M:%S")
        end

        reservation_change_available_status reservation
        @reservation_density = reservation
      end  
    end
  end

  def commit
    if !@reservation_density.nil?  &&  @reservation_density.valid? 
      @reservation_density.save
    end

    if !@reservation_pronto.nil? && @reservation_pronto.valid? 
      @reservation_pronto.save      
    else   
      @reservation_pronto.errors
    end    

  end

  def reservation_not_available
    start_at = params[:start_at].to_date
    end_at = params[:end_at].to_date
    time_start =params[:time_start]
    time_end = params[:time_end]
    weekdays = params[:weekdays]
    
    range_dates = (start_at..end_at).to_a.select{ |k| weekdays.include?(k.wday.to_s)}
    hours_not_available = []

    office = Office.find(params[:office_id])
    
    range_dates.each do |d|     
      start_at = (d.to_s + ' ' + office.start_at.to_s).to_datetime.strftime("%Y-%m-%dT%H:%M:%S")
      end_at = (d.to_s + ' ' + office.end_at.to_s).to_datetime.strftime("%Y-%m-%dT%H:%M:%S")   
      
      hours_not_available << ReservationAvailable.where(start_at: start_at..end_at, available: false, clinic_id: @params[:clinic_id]).pluck(:start_at)
    end

    hours_not_available =  hours_not_available.reject(&:blank?)

    unless hours_not_available.empty?      
      not_available =   hours_not_available.first.count > 0 ? hours_not_available.first : hours_not_available.last  
      hours = not_available.map{ |k| k.strftime('%H')}.uniq.sort   
      hours.values_at(0,-1).to_a
    else
      []
    end
  end

  def set_reservation_for_unavailable
     reservate_date = params[:start_at].to_date   
  end

  def reservation_not_available_day 
    start_at = params[:start_at].to_date     

    hours_not_available =  ReservationAvailable.where(date: start_at, available: false, clinic_id: params[:clinic_id]).pluck(:start_at)
    hours_not_available = hours_not_available.reject(&:blank?)

    unless hours_not_available.empty?     
      hours = hours_not_available.map{ |k| k.strftime('%H')}.uniq.sort     
      hours.values_at(0,-1).to_a
    else
      []
    end
  end

end