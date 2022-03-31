# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :contracts
  has_one :medical_info, dependent: :destroy
  has_many :contract_combos, dependent: :delete_all
  has_many :doctors

  accepts_nested_attributes_for :medical_info
  accepts_nested_attributes_for :doctors, reject_if: :all_blank, allow_destroy: true

  validates :name, :email, :document, presence: true

  alias_attribute :value, :name

  def to_param
    [id, name.parameterize].join('-')
  end
end
