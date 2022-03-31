# frozen_string_literal: true

class CleanReservationsOnDayOffWorker
  include Sidekiq::Worker

  # Case scenario
  #
  # Reservations were created BEFORE the day off feature, and never been removed after that
  def perform
    DayOff.all.each do |day_off|
      reservations_on_day_off = Reservation.where('date = ?', day_off.date.to_s).pluck(:id)
      PayrollItem.where('reservations_id IN (?)', reservations_on_day_off).destroy_all unless reservations_on_day_off.empty?
      Reservation.where('id IN (?)', reservations_on_day_off).destroy_all
    end
    'Running job'
  end
end
