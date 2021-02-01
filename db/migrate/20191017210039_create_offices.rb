class CreateOffices < ActiveRecord::Migration[6.0]
  def change
    create_table :offices do |t|
      t.string :name
      t.string :code
      t.text :address
      t.string :phone
      t.string :phone_secondary
      t.integer :status, default: 0
      t.text :opening_hours
    end
  end
end
