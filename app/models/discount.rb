# frozen_string_literal: true

# Descontos em Contratos
class Discount < ApplicationRecord
  belongs_to :contract

  validates :amount, :starts_at, :ends_at, presence: true
end
