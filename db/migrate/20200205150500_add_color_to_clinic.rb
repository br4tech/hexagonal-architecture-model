class AddColorToClinic < ActiveRecord::Migration[6.0]
  def change
    add_column :clinics, :color, :string
  end
end
