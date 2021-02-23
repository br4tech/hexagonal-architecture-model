class CreateReschedulingAlloweds < ActiveRecord::Migration[6.0]
  def change
    create_table :rescheduling_alloweds do |t|
      t.references :client, null: false, foreign_key: true
      t.integer :used, default: 0
      t.integer :available, default: 0

      t.timestamps
    end
  end
end
