class AddParkingValueToContract < ActiveRecord::Migration[6.0]
  def change
    add_column :contracts, :parking_value, :decimal, precision: 8, scale: 2
  end
end
