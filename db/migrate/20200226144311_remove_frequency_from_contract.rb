class RemoveFrequencyFromContract < ActiveRecord::Migration[6.0]
  def change
    remove_column :contracts, :frequency, :integer
  end
end
