# frozen_string_literal: true

module Bills
  # Get bills to process
  class GenerateBills
    attr_reader :contract, :reference_date

    def initialize(contract, reference_date)
      @contract = contract
      @reference_date = reference_date
    end

    def generate
      reservation = Reservations::ReservationToBills.new(contract, reference_date)
      reservations = reservation.reservation_with_contract

      return if reservations.empty?

      bill = bill_build(reservation)
      bill_items(reservations, bill.id)
    end

    def bill_build(reservation)
      Payroll.find_or_create_by(
        emission: Time.zone.today,
        due_at: reservation.with_contract_due_at,
        revenues_at: reservation.with_contract_date_cut_start,
        contract_id: contract.id,
        starts_at: reservation.with_contract_date_cut_start,
        ends_at: reservation.with_contract_date_cut_end
      )
    end

    def bill_items(reservations, bill_id)
      reservations.each do |reservation|
        PayrollItem.find_or_create_by(
          period: reservation.date,
          clinic_id: reservation.clinic_id,
          hours: worked_hours(reservation),
          payroll_id: bill_id,
          reservations_id: reservation.id,
          amount: amount(reservation)
        )
      end
    end

    def amount(reservation)
      hours = worked_hours(reservation)
      discount_amount(hours, reservation.amount)
    end

    def worked_hours(reservation)
      (reservation.start_at - reservation.end_at).to_i.abs / 3600
    end

    def discount_amount(hours, amount)
      return discount_no_aplyed(hours, amount) if contract.discounts.empty?

      contract.discounts.each do |discount|
        amount = if validate_discount(discount)
                   discount_applyed(hours, discount, amount)
                 else
                   discount_no_aplyed(hours, amount)
                 end
      end
      amount
    end

    def validate_discount(discount)
      today = Time.zone.now
      discount.starts_at <= today && today <= discount.ends_at
    end

    def discount_applyed(hours, discount, amount)
      if contract.category?
        discounts_private_applyed(discount, amount)
      else
        discount_settled_aplyed(hours, discount, amount)
      end
    end

    def discount_no_aplyed(hours, amount)    
      unless contract.category?
        amount
      else
        amount * hours
      end
    end

    def discount_settled_aplyed(hours, discount, amount)
      amount * hours - (amount * hours) * (discount.amount / 100)
    end

    def discounts_private_applyed(discount, amount)
      (amount - amount * (discount.amount / 100))
    end
  end
end
