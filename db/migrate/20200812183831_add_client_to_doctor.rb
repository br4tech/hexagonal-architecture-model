class AddClientToDoctor < ActiveRecord::Migration[6.0]
  def change
    add_reference :doctors, :client, null: true, foreign_key: true
  end
end
