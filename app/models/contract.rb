# frozen_string_literal: true

# Contratos
class Contract < ApplicationRecord
  enum contract_types: { settled: 0, type_private: 2 } # Fixo ou Por Hora

  belongs_to :contract_combo, optional: true
  belongs_to :client
  has_many :discounts
  has_many :attendances
  has_many :offices, through: :attendances

  accepts_nested_attributes_for :client, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :discounts, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :attendances, reject_if: :all_blank, allow_destroy: true

  validates :starts_at, :ends_at, :amount, :revenues_at, :due_at, :forfeit, :kind,
            :rescheduling_allowed, presence: true

  validates_associated :discounts, :attendances

  before_save :contract_type_private

  # Defaults
  attribute :starts_at, :datetime, default: Date.today.strftime('%d/%m/%Y')
  attribute :ends_at, :datetime, default: 1.year.from_now.strftime('%d/%m/%Y')
  attribute :kind, :integer, default: 0
  attribute :due_at, :integer, default: 0o1
  attribute :revenues_at, :integer, default: 20
  attribute :rescheduling_allowed, :integer, default: 0
end
