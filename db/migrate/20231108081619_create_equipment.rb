class CreateEquipment < ActiveRecord::Migration[7.0]
  def change
    create_table :equipment do |t|
      t.string :name, null: false
      t.integer :position, default: 0, null: false
      t.boolean :unlocked , default: false, null: false
      t.timestamps
    end
  end
end
