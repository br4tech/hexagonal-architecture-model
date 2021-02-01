class AddOddToPayrollItem < ActiveRecord::Migration[6.0]
  def change
    add_column :payroll_items, :odd, :boolean, default: false
  end
end
