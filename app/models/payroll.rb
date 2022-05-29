# frozen_string_literal: true

# Financeiro
class Payroll < ApplicationRecord
  paginates_per 50

  belongs_to :contract
  has_many :payroll_items

  validates :emission, presence: true
  validates :due_at, presence: true

  delegate :client, to: :contract

  def kind
    self.contract.category == 1 ? "desenty" : "pronto"
  end
end
