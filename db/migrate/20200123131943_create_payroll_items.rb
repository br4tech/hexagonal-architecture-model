class CreatePayrollItems < ActiveRecord::Migration[6.0]
  def change
    create_table :payroll_items do |t|
      t.date :period     
      t.references :clinic, null: false, foreign_key: true
      t.integer :hours
      t.decimal :amount, precision: 15, scale: 4
      t.references :payroll, null: false, foreign_key: true

      t.timestamps
    end
  end
end
