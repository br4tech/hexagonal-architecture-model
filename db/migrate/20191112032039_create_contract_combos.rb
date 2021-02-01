class CreateContractCombos < ActiveRecord::Migration[6.0]
  def change
    create_table :contract_combos do |t|
      t.references :client, null: false, foreign_key: true
    end
  end
end