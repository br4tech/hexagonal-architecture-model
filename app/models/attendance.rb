# frozen_string_literal: true

# Dados de Atendimentos dos Contratos
class Attendance < ApplicationRecord
  enum wdays: { 'Dom' => 0, 'Seg' => 1, 'Ter' => 2, 'Qua' => 3, 'Qui' => 4, 'Sex' => 5, 'Sab' => 6 }
  enum frequencies: { weekly: 0, biweekly: 1 }

  belongs_to :contract
  belongs_to :office
  belongs_to :clinic

  has_many :reservations, dependent: :delete_all

  validates :weekdays, :starts_at, :ends_at, :time_starts, :time_ends, :frequency, presence: true

  # before_update :alter_reserves
  # before_destroy :alter_reservation_for_available

  def alter_reserves
    reserve = Reservation.where(contract_id: contract_id)
    reserve.each do |r|
      PayrollItem.destroy_by(reservations_id: r.id)
    end
    Reservation.destroy_by(contract_id: contract_id)
  end

  def alter_reservation_for_available
    reservations_nonavailable = ReservationAvailable.where(start_at: Date.today..ends_at,
                                                           clinic_id: clinic_id, available: false)

    reservations_nonavailable.each do |r|
      r.available = true
      r.save
    end

    PayrollItem.delete_by(period: Date.today..ends_at, clinic_id: clinic_id)

    Reservation.delete_by(start_at: Date.today...ends_at,
                          clinic_id: clinic_id, odd: false)
  end
end
