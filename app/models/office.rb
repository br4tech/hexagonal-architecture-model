# frozen_string_literal: true

# Unidades
class Office < ApplicationRecord
  validates_presence_of  :name, :code

  has_many :clinics, dependent: :nullify
  has_many :accesses, dependent: :delete_all

  def to_param
    [id, name.parameterize].join('-')
  end

  scope :office_with_clinics, -> { 
    where("(SELECT COUNT(*) FROM public.clinics WHERE clinics.office_id = offices.id ) > 0")
    .order(:id)}

  def self.revenue_per_unit(office, month)
    Office.find_by_sql("SELECT offices.name, sum(payroll_items.amount) As amount FROM offices
      INNER JOIN clinics ON clinics.office_id = offices.id
      INNER JOIN payroll_items ON payroll_items.clinic_id =clinics.id
      WHERE clinics.office_id  = #{office} AND extract(month from payroll_items.period)=#{month.to_i }
      GROUP BY offices.name
      ").pluck(:name, :amount)
  end

  def self.hour_per_unit(office, month)
    Office.find_by_sql("SELECT offices.name, sum(payroll_items.hours) As amount FROM offices
      INNER JOIN clinics ON clinics.office_id = offices.id
      INNER JOIN payroll_items ON payroll_items.clinic_id =clinics.id
      WHERE clinics.office_id  = #{office} AND extract(month from payroll_items.period)=#{month.to_i}
      GROUP BY offices.name
      ").pluck(:name, :amount)
  end

  def self.report_all_for_hours
    Office.find_by_sql("SELECT offices.name, sum(payroll_items.hours) As hours FROM offices
      INNER JOIN clinics ON clinics.office_id = offices.id
      INNER JOIN payroll_items ON payroll_items.clinic_id =clinics.id      
      GROUP BY offices.name
      ")
  end

  def self.report_all_for_revenues
    Office.find_by_sql("SELECT offices.name, sum(payroll_items.amount) As amount FROM offices
      INNER JOIN clinics ON clinics.office_id = offices.id
      INNER JOIN payroll_items ON payroll_items.clinic_id =clinics.id      
      GROUP BY offices.name
      ")
  end
end
