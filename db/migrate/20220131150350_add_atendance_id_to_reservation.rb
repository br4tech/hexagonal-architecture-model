class AddAtendanceIdToReservation < ActiveRecord::Migration[6.0]
  def change
    add_reference :reservations, :attendances, null: true, foreign_key: true
  end
end
