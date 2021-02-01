class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts do |t|
      t.decimal :amount, precision: 15, scale: 2
      t.datetime :starts_at
      t.datetime :ends_at
      t.references :contract, null: false, foreign_key: true
    end
  end
end
