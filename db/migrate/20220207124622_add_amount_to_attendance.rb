class AddAmountToAttendance < ActiveRecord::Migration[6.0]
  def change
    add_column :attendances, :amunt, :decimal, precision: 8, scale: 2
  end
end
