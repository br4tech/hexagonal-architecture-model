class CreatePersonKinds < ActiveRecord::Migration[6.0]
  def change
    create_table :person_kinds do |t|
      t.string :description

      t.timestamps
    end
  end
end
