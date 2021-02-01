class AddOddReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :odd,  :boolean, default: false
  end
end
