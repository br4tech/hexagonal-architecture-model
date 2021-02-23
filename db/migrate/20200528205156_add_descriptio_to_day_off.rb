class AddDescriptioToDayOff < ActiveRecord::Migration[6.0]
  def change
    add_column :day_offs, :description, :string
  end
end
