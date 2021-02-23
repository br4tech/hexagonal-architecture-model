class AddAvailableToReservationAvailable < ActiveRecord::Migration[6.0]
  def change
    add_column :reservation_availables, :available, :boolean, default: true
  end
end
