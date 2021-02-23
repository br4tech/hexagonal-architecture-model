class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :document
      t.integer :wallet
      t.integer :agency
      t.integer :current_account
      t.integer :digit
      t.string :company_code
      t.integer :shipping_sequence

      t.timestamps
    end
  end
end
