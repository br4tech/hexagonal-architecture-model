# frozen_string_literal: true

class Doctor < ApplicationRecord  
  enum gender: { male: 0, female: 1 }

  belongs_to :client  
  has_many :expertises, dependent: :delete_all

  accepts_nested_attributes_for :expertises, allow_destroy: true

  validates_presence_of :name, :email, :phone, :document, :crm

  alias_attribute :value, :name

  def to_param
    [id, name.parameterize].join('-')
  end
end