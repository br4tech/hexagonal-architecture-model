# frozen_string_literal: true

module Reservations
  # Get reservations
  class ReservationToBills
    attr_reader :contract, :reference_date

    def initialize(contract, reference_date)
      @contract = contract
      @reference_date = reference_date
    end

    def reservation_with_contract
      reservations = []
      contract.attendances.each do |attendance|
        contract = reservation_contract(attendance)
        odd = reservation_odd(attendance)

        reservations << contract + odd
      end
      transform_in_single_array(reservations)
    end

    def reservation_contract(attendance)
      Reservation.where(attendance_id: attendance.id, odd: false)
                 .where('date >= ? AND date < ?',
                        with_contract_date_cut_start.to_date,
                        with_contract_date_cut_end.to_date)
                 .select(select_params)
    end

    def reservation_odd(attendance)
      Reservation.where(attendance_id: attendance.id, odd: true)
                 .where('date >= ? AND date < ?',
                        with_contract_odd_date_cut_start.to_date,
                        with_contract_odd_date_cut_end.to_date)
                 .select(select_params)
    end

    def reservation_without_contract
      Reservation.where(odd: true)
                 .where('date >= ? AND date < ?',
                        with_contract_date_cut_start.to_date,
                        with_contract_date_cut_end.to_date)
                 .select(select_params)
    end

    def transform_in_single_array(reservation_array)
      reservations = []
      reservation_array.each do |reservation|
        reservation.map do |array|
          reservations << array
        end
      end
      reservations.uniq
    end

    def with_contract_due_at
      "#{@contract.due_at}/#{with_contract_end_month}/#{reference_year}".to_date
    end

    def with_contract_date_cut_start
      "#20/#{with_contract_start_month}/#{reference_year}".to_date
    end

    def with_contract_date_cut_end
      "#20/#{with_contract_end_month}/#{reference_year}".to_date
    end

    def with_contract_odd_date_cut_start
      "#20/#{with_contract_odd_start_month}/#{reference_year}".to_date
    end

    def with_contract_odd_date_cut_end
      "#20/#{with_contract_odd_end_month}/#{reference_year}".to_date
    end

    def without_contract_date_cut_start
      "#{@contract.revenues_at}/#{without_contract_start_month}/#{reference_year}".to_date
    end

    def without_contract_date_cut_end
      "#{@contract.revenues_at}/#{without_contract_end_month}/#{reference_year}".to_date
    end

    private

    def select_params
      %w[id clinic_id date start_at end_at odd attendance_id]
    end

    def with_contract_start_month
      reference_date.to_date.month
    end

    def with_contract_end_month
      reference_date.to_date.month + 1
    end

    def with_contract_odd_start_month
      reference_date.to_date.month - 1
    end

    def with_contract_odd_end_month
      reference_date.to_date.month
    end

    def without_contract_start_month
      reference_date.to_date.month - 1
    end

    def without_contract_end_month
      reference_date.to_date.month
    end

    def reference_year
      year = reference_date.to_date.year
      if with_contract_end_month > 12
        year + 1
      else
        year
      end
      year
    end
  end
end
