# frozen_string_literal: true

# Reservations
module Reservations
  # Reservations to schedule
  class ReservationToSchedule
    attr_reader :contract

    def initialize(contract)
      @contract = contract
    end

    def reservation_per_office
      Reservation.find(office_id: @office_id)
                 .select(select_params)
    end

    def reservation_canceled
      Reservation.where(canceled: true).select(select_params)
    end

    def reservation_per_attendance
      reservations = []
      @contract.attendances.each do |attendance|
        reservations << reservation_with_type_attendance(attendance)
        ReservationCreator.build_reservation(reservations[0], attendance)
      end
      
      reservations
    end

    def reservation_with_type_attendance(attendance)
      reservations = []
      reservations << if attendance.frequency == Attendance.frequencies[:weekly]
                        reservation_per_weekly(attendance)
                      else
                        reservation_per_biweekweeklyly(attendance)
                      end
      reservations
    end

    def reservation_per_weekly(attendance)
      work_days = agroup_reservation(attendance)
      agroup_per_week(work_days, attendance)
    end

    def reservation_per_biweekweeklyly(attendance)
      work_days = agroup_reservation(attendance)
      agroup_per_biweekweeklyly(work_days, attendance)
    end

    def agroup_reservation(attendance)
      start_at = attendance.starts_at.to_date.beginning_of_week
      end_at = attendance.ends_at.to_date

      WorkDay.work_day_between(
        start_at,
        end_at
      )
    end

    def agroup_per_week(work_days, attendance)
      agroup_days = work_days.to_a.in_groups_of(6)
      start_work_day(agroup_days, attendance)
    end

    def agroup_per_biweekweeklyly(work_days, attendance)
      biweekweeklyly = []
      agroup_days = work_days.to_a.in_groups_of(6)
      agroup_days.each_with_index do |reservation, index|
        if Attendance.wdays[:Sab] <= attendance.starts_at.wday
          biweekweeklyly << reservation if index.odd?
        elsif index.even?
          biweekweeklyly << reservation
        end
      end
      start_work_day(biweekweeklyly, attendance)
    end

    def start_work_day(reservations, attendance)
      work_days = []
      reservations.map do |reservation|
        reservation.select do |day|
          work_days << day if !day.nil? && day >= attendance.starts_at
        end
      end
      selected_day_of_week(work_days, attendance)
    end

    def selected_day_of_week(reservations, attendance)
      week_days = []
      reservations.select do |reservation|
        week_days << reservation if attendance.weekdays.include?(reservation.wday)
      end
      WorkDay.remove_days_off(week_days)
    end

    def clear_agroup(reservations)
      groups_clear = []
      reservations.map do |reservation|
        unless reservation.empty?
          groups_clear << reservation
        end.reject(&:blank)
      end
      groups_clear
    end

    private

    def select_params
      %w[id clinic.code date category odd]
    end
  end
end
