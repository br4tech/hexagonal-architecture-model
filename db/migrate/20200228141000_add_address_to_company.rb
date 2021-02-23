class AddAddressToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :city, :string
    add_column :companies, :state, :string
    add_column :companies, :zipcode, :string
    add_column :companies, :address, :string
    add_column :companies, :neighborhood, :string
  end
end
