# frozen_string_literal: true

# Dados de Atendimentos dos Contratos
class Attendance < ApplicationRecord 
  enum wdays: %w(Dom Seg Ter Qua Qui Sex Sab) 
  enum frequencies: { weekly: 0, biweekly: 1} 
  
  belongs_to :contract
  belongs_to :office
  belongs_to :clinic

  has_many :reservations, dependent: :delete_all

  validates_presence_of :weekdays, :starts_at, :ends_at, :time_starts, :time_ends, :frequency

  # before_update :alter_reserves
  # before_destroy :alter_reservation_for_available


  def alter_reserves
     reserve = Reservation.where(contract_id: self.contract_id)
     reserve.each do |r|
       PayrollItem.destroy_by(reservations_id: r.id)
     end
     Reservation.destroy_by(contract_id: self.contract_id)
  end

  def alter_reservation_for_available   
    reservations_nonavailable = ReservationAvailable.where(start_at: Date.today..self.ends_at,
      clinic_id: self.clinic_id, available: false)

    reservations_nonavailable.each do |r| 
      r.available = true       
      r.save
    end   

    PayrollItem.delete_by(period: Date.today..self.ends_at, clinic_id: self.clinic_id )
    
    Reservation.delete_by(start_at: Date.today...self.ends_at,
      clinic_id: self.clinic_id, odd: false)
  end

end
