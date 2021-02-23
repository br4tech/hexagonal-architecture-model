class AddCanceledToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :canceled, :boolean, default: false
  end
end
