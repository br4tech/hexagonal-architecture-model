class ReservationAvailableWorker
  include Sidekiq::Worker

  def perform(*args)
    reservations = Reservation.where("date > ?", Time.now - 1.month)
    reservations.each do |reservation|
      start_at = (reservation.date.to_s + ' '+ reservation.start_at.to_s).to_datetime.strftime("%Y-%m-%dT%H:%M:%S")
      end_at =  (reservation.date.to_s + ' ' + reservation.end_at.to_s).to_datetime.strftime("%Y-%m-%dT%H:%M:%S")
      
      availables = ReservationAvailable.where(
        clinic_id: reservation.clinic_id, 
        start_at: start_at..end_at)   
   
        availables.each do |available|
          available.available = false                    
          available.save
        end  
    end
    p "Reservas bloqueadas com sucesso!"
  end
end