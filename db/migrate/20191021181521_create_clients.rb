class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|  
      t.string :name 
      t.string :email
      t.integer  :kind
      t.string :phone
      t.boolean :status    
      t.string :document
      t.string :zipcode
      t.string :street
      t.string :number
      t.string :complement
      t.string :neighborhood
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
