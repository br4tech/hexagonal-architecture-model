class RemoveContractIdFromReservation < ActiveRecord::Migration[6.0]
  def change
     remove_column :reservations, :contract_id
  end
end
