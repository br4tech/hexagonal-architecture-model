# frozen_string_literal: true

# Salas
class Clinic < ApplicationRecord
  belongs_to :office
  has_many :attendances
  has_many :reservations

  validates :code, :color, presence: true

  scope :clinic_with_reservation, lambda { |id|
                                    where(office_id: id)
                                      .order('clinics.id')
                                  }

  def self.revenue_per_office(unit, month)
    Office.find_by_sql("SELECT clinics.code as name, sum(payroll_items.amount) As amount FROM clinics
        INNER JOIN payroll_items ON payroll_items.clinic_id =clinics.id
        WHERE clinics.office_id  = #{unit} AND extract(month from payroll_items.period)=#{month.to_i}
        GROUP BY clinics.code
        ").pluck(:name, :amount)
  end

  def self.hour_per_office(unit, month)
    Office.find_by_sql("SELECT clinics.code as name, sum(payroll_items.hours) As amount FROM clinics
      INNER JOIN payroll_items ON payroll_items.clinic_id =clinics.id
      WHERE clinics.office_id  = #{unit} AND extract(month from payroll_items.period)=#{month.to_i}
      GROUP BY clinics.code
      ").pluck(:name, :amount)
  end
end
