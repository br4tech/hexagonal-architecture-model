class CreateClinics < ActiveRecord::Migration[6.0]
  def change
    create_table :clinics do |t|
      t.references :office, null: false, foreign_key: true
      t.string :code
      t.integer :status, status: 0
      t.decimal :price, precision: 15, scale: 2
      t.string :metrics
      t.string :medical_specialties
    end
  end
end
