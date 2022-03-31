# frozen_string_literal: true

class ReservationWithoutContract < ApplicationRecord
  belongs_to :client
  belongs_to :office
  belongs_to :clinic

  accepts_nested_attributes_for :client

  before_save :update_date

  def update_date
    self.start_at = DateTime.new(date.year, date.month, date.day, start_at.hour, start_at.min, start_at.sec)
    self.end_at = DateTime.new(date.year, date.month, date.day, end_at.hour, end_at.min, end_at.sec)
  end

  def all_day_reservation
    date == start_at.midnight && end_at == end_at.midnight ? true : false
  end
end
