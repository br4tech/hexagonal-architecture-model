class AddStartAtAndEndatToReservationWithoutContract < ActiveRecord::Migration[6.0]
  def change
    add_column :reservation_without_contracts, :start_at, :datetime
    add_column :reservation_without_contracts, :end_at, :datetime
  end
end
