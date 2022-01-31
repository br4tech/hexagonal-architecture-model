class Reservation < ApplicationRecord
  belongs_to :attendance, optional: true
  belongs_to :office
  belongs_to :clinic

  validates :date, :start_at, :end_at, presence: true
  validates :clinic_id, uniqueness: { scope: %i[date start_at] }
end
