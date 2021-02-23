class AddTimeToAttendance < ActiveRecord::Migration[6.0]
  def change
    add_column :attendances, :time_starts, :time
    add_column :attendances, :time_ends, :time
  end
end
