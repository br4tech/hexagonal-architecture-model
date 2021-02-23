class AddReschedulingUsedToContract < ActiveRecord::Migration[6.0]
  def change
    add_column :contracts, :rescheduling_used, :integer, default: 0
  end
end
