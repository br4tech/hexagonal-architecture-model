class AddStartAndEndAtToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :start_at, :datetime
    add_column :reservations, :end_at, :datetime
  end
end
