class  CreateClientDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :client_doctors do |t|
      t.references :client, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true
    end
  end
end