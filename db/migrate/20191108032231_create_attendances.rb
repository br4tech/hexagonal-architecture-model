class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.references :contract, null: false, foreign_key: true
      t.references :clinic, null: false, foreign_key: true
      t.references :office, null: true, foreign_key: false
      t.integer :weekdays, array: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :is_recurrent, default: false
    end
  end
end
