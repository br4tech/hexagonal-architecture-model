# frozen_string_literal: true

class PayrollItem < ApplicationRecord
  belongs_to :clinic
  belongs_to :payroll

  validates :hours, presence: true
  validates :amount, presence: true
  validates :period, presence: true
end
