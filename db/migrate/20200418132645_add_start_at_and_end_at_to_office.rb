class AddStartAtAndEndAtToOffice < ActiveRecord::Migration[6.0]
  def change
    add_column :offices, :start_at, :datetime
    add_column :offices, :end_at, :datetime
  end
end
