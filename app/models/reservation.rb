class Reservation < ApplicationRecord
  belongs_to :contract
  belongs_to :office
  belongs_to :clinic

  validates :date, :start_at, :end_at, presence: true

  before_save :update_date

  scope :reserve_in_month, -> (date){ 
    joins(:contract)   
    .where("date between ? AND ?", date.beginning_of_month, date.end_of_month)
  }

  scope :reserve_in_month_office, -> (office_id, date){ 
    joins(:contract, :clinic)
    .where("office_id= #{office_id} AND date between ? AND ?", date.beginning_of_month, date.end_of_month)
  }

  def update_date
    self.start_at = DateTime.new(date.year, date.month,date.day,start_at.hour, start_at.min, start_at.sec)
    self.end_at = DateTime.new(date.year, date.month,date.day,end_at.hour, end_at.min, end_at.sec)
  end

  def all_day_reservation
    self.date == self.start_at.midnight && self.end_at == self.end_at.midnight ? true : false
  end
end
