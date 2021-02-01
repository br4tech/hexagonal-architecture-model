# frozen_string_literal: true

# Descontos em Contratos
class Discount < ApplicationRecord
  belongs_to :contract

  validates_presence_of :amount, :starts_at, :ends_at
end
