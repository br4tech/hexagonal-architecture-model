class AddComboToContract < ActiveRecord::Migration[6.0]
  def change
    add_reference :contracts, :contract_combo, null: true, foreign_key: true    
  end
end