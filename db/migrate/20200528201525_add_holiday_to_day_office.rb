class AddHolidayToDayOffice < ActiveRecord::Migration[6.0]
  def change
    add_reference :day_offs, :holiday, null: false, foreign_key: true
  end
end
