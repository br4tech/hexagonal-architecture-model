class CreateReservationAvailables < ActiveRecord::Migration[6.0]
  def change
    create_table :reservation_availables do |t|
      t.datetime :date
      t.references :clinic, null: false, foreign_key: false
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
