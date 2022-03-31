# frozen_string_literal: true

class DayOff < ApplicationRecord
  belongs_to :holiday

  validates :date, presence: true

  scope :year, lambda { |year|
                 where(' EXTRACT(YEAR FROM date) = ? ', year).pluck(:date) if year.present?
               }
end
