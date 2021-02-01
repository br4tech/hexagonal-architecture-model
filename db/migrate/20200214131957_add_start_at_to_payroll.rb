class AddStartAtToPayroll < ActiveRecord::Migration[6.0]
  def change
    add_column :payrolls, :starts_at, :datetime
  end
end
