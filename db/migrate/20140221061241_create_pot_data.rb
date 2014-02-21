class CreatePotData < ActiveRecord::Migration
  def change
    create_table :pot_data do |t|
      t.integer :level

      t.timestamps
    end
  end
end
