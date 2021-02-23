class AddParkingValueToPayroll < ActiveRecord::Migration[6.0]
  def change
    add_column :payrolls, :parking_value, :decimal, precision: 8, scale: 2, default: 0
  end
end
