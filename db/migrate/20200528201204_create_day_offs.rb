class CreateDayOffs < ActiveRecord::Migration[6.0]
  def change
    create_table :day_offs do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
