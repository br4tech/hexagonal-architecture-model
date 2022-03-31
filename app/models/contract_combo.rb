# frozen_string_literal: true

class ContractCombo < ApplicationRecord
  belongs_to :client
  has_many :contracts

  def main_contract
    contracts.first
  end

  delegate :starts_at, to: :main_contract

  delegate :ends_at, to: :main_contract

  delegate :offices, to: :main_contract
end
