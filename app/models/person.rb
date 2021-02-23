class Person < ApplicationRecord
  belongs_to :person_kind
  has_one :client
  has_one :doctor

  accepts_nested_attributes_for :doctor, :client
end
