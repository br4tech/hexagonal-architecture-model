class RenameDescriptionToColor < ActiveRecord::Migration[6.0]
  def change
    rename_column :holidays, :description, :color
  end
end
