class CreatePayrolls < ActiveRecord::Migration[6.0]
  def change
    create_table :payrolls do |t|
      t.date :emission
      t.references :contract, null: false, foreign_key: true
      t.decimal :amount, precision: 15, scale: 4
      t.datetime :ends_at
      t.date :due_at
      t.boolean :status

      t.timestamps
    end
  end
end
