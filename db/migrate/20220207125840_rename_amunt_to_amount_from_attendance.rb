class RenameAmuntToAmountFromAttendance < ActiveRecord::Migration[6.0]
  def change
     rename_column :attendances, :amunt, :amount
  end
end
