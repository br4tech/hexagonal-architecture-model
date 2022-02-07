class Reservation < ApplicationRecord
  belongs_to :attendance, optional: true
  belongs_to :office
  belongs_to :clinic

  validates :date, :start_at, :end_at, presence: true
  # validates :clinic_id, uniqueness: { scope: %i[date start_at] }

  delegate :amount, to: :attendance

  def all_day_reservation
    self.date == self.start_at.midnight && self.end_at == self.end_at.midnight ? true : false
  end
end
