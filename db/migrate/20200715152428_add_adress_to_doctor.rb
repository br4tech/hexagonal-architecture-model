class AddAdressToDoctor < ActiveRecord::Migration[6.0]
  def change
    add_column :doctors, :zipcode, :string
    add_column :doctors, :address, :string
    add_column :doctors, :number, :integer
    add_column :doctors, :complement, :string
    add_column :doctors, :neighborhood, :string
    add_column :doctors, :city, :string
    add_column :doctors, :state, :string
  end
end
