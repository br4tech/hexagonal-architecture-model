class RemoveAmountFromPayroll < ActiveRecord::Migration[6.0]
  def change

    remove_column :payrolls, :amount, :decimal
  end
end
