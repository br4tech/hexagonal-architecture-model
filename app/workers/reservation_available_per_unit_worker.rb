# frozen_string_literal: true

class ReservationAvailablePerUnitWorker
  include Sidekiq::Worker

  def perform(*_args)
    offices = Office.all
    start_range = Date.today
    end_range = start_range.end_of_year

    offices.each do |office|
      start_at = office.start_at
      end_at = office.end_at
      diff_hours = (start_at - end_at).to_i.abs / 3600

      office.clinics.each do |clinic|
        available_dates = (start_range..end_range).to_a.select { |r| office.weekdays.include?(r.wday) }.reject(&:blank?)

        available_dates.each do |available_date|
          i = 0
          (1..diff_hours).each do |i|
            start = DateTime.new(available_date.year, available_date.month, available_date.day, start_at.hour, start_at.min, start_at.sec)
            start = i > 1 ? start + i.to_i.hours : start

            ReservationAvailable.find_or_create_by(
              clinic_id: clinic.id,
              date: available_date.to_date,
              start_at: start,
              end_at: start
            )
          end
        end
      end
    end
    Rails.logger.debug 'Reservas disponiveis geradas com sucesso!'
  end
end
