# frozen_string_literal: true

# Reservations
module Reservations
  # Create reservation in database
  class ReservationCreator
    def self.build_reservation(reservations, attendance)
      reservations[0].each do |reservation|
        create(reservation, attendance)
      end
    end

    def self.create(reservation, attendance)
      Reservation.create(
        attendance_id: attendance.id,
        date: reservation.to_date,
        office_id: attendance.office_id,
        clinic_id: attendance.clinic_id,
        start_at: start_at(reservation.to_date, attendance),
        end_at: end_at(reservation.to_date, attendance)
      )
    end

    def self.start_at(reservation, attendance)
      DateTime.new(
        reservation.year,
        reservation.month,
        reservation.day,
        attendance.time_starts.hour,
        attendance.time_starts.min
      )
    end

    def self.end_at(reservation, attendance)
      DateTime.new(
        reservation.year,
        reservation.month,
        reservation.day,
        attendance.time_ends.hour,
        attendance.time_ends.min
      )
    end
  end
end
