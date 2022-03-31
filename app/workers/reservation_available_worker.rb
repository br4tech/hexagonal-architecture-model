# frozen_string_literal: true

class ReservationAvailableWorker
  include Sidekiq::Worker

  def perform(*_args)
    reservations = Reservation.where('date > ?', Time.zone.now - 1.month)
    reservations.each do |reservation|
      start_at = "#{reservation.date} #{reservation.start_at}".to_datetime.strftime('%Y-%m-%dT%H:%M:%S')
      end_at = "#{reservation.date} #{reservation.end_at}".to_datetime.strftime('%Y-%m-%dT%H:%M:%S')

      availables = ReservationAvailable.where(
        clinic_id: reservation.clinic_id,
        start_at: start_at..end_at
      )

      availables.each do |available|
        available.available = false
        available.save
      end
    end
    Rails.logger.debug 'Reservas bloqueadas com sucesso!'
  end
end
