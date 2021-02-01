# frozen_string_literal: true

# Financeiro
class Payroll < ApplicationRecord
  belongs_to :contract
  has_many :payroll_items

  validates :emission, presence: true
  validates :due_at, presence: true  

end
