class CreateReservationWithoutContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :reservation_without_contracts do |t|
      t.references :client, null: false, foreign_key: true
      t.datetime :date
      t.references :office, null: false, foreign_key: true
      t.references :clinic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
