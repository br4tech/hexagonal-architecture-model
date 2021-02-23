class AddRevenuesToPayroll < ActiveRecord::Migration[6.0]
  def change
    add_column :payrolls, :revenues_at, :date
  end
end
