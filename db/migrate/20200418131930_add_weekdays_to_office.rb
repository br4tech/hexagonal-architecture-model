class AddWeekdaysToOffice < ActiveRecord::Migration[6.0]
  def change
    add_column :offices, :weekdays, :integer, array: true
  end
end
