class Holiday < ApplicationRecord
  validates_presence_of :name, :color, :starts_at, :ends_at,  presence: true
end
