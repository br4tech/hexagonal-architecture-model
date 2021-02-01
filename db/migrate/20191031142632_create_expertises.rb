class CreateExpertises < ActiveRecord::Migration[6.0]
  def change
    create_table :expertises do |t|
      t.string :name
      t.references :doctor, null: false, foreign_key: true
      t.string :duration
      t.decimal :price, precision: 15, scale: 2
      t.integer :days_to_return, default: 15
      t.boolean :returns, default: true
      t.boolean :confirm, default: true
      t.text :observations
    end
  end
end
