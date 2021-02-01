class DayOff < ApplicationRecord
  belongs_to :holiday
  has_many  :day_offs

  validates :date, presence: true
end
