class AddFrequencyToAttendance < ActiveRecord::Migration[6.0]
  def change
    add_column :attendances, :frequency, :integer
  end
end
