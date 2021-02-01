
class ReservationWithoutContractService
  attr_reader :params
  attr_accessor :reservation_without_contract

  def initialize(params)
    @params = params 
  end

  def create
    ReservationWithoutContract.transaction do 
      build
      reservation_available     
      commit
    end
  end

  def update
    ReservationWithoutContract.transaction do 
      reservation_available
      rebuild
      commit
    end
  end

  def destroy
  end


  def reservation_available
    start_at = (@params["date"].to_s + ' ' + @params["start_at"].to_s).to_datetime.strftime("%Y-%m-%dT%H:%M:%S")
    end_at =  (@params["date"].to_s + ' ' + @params["end_at"].to_s).to_datetime.strftime("%Y-%m-%dT%H:%M:%S")
  
    reservations = ReservationAvailable.where(
      clinic_id: @params["clinic_id"], 
      start_at: start_at..end_at, 
      available: true) 

    reservations.each do |reservation|
      if reservation.available 
          reservation.available = false             
      else     
        reservation.available = true       
      end  
      reservation.save
    end           
  end

  def build
    @reservation_without_contract =  ReservationWithoutContract.new(params)
  end

  def rebuild
    @reservation_without_contract = ReservationWithoutContract.find(params[:id])
    @reservation_without_contract.assign_attributes(@params)
  end
  
  def commit
    if @reservation_without_contract.valid?
      @reservation_without_contract.save
    else
      @reservation_without_contract.errors.full_messages
    end
  end
end