class CreateDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors do |t|
      t.string :name 
      t.string :email
      t.string :phone 
      t.string :document            
      t.string :crm  
      t.integer :gender

      t.timestamps    
    end

    # add_index :doctors, :email, unique: true
  end
end