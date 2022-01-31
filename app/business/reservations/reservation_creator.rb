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
      Reservation.find_or_create_by(
        attendance_id: attendance.id,
        date: reservation.to_date,
        office_id: attendance.office_id,
        clinic_id: attendance.clinic_id,
        start_at: attendance.time_starts,
        end_at: attendance.time_ends
      )
    end
  end
end
