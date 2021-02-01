class AddColorToDayOff < ActiveRecord::Migration[6.0]
  def change
    add_column :day_offs, :color, :string
  end
end
