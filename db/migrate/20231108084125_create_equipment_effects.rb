class CreateEquipmentEffects < ActiveRecord::Migration[7.0]
  def change
    create_table :equipment_effects do |t|
      t.references :equipment, null: false, foreign_key: true
      t.references :effect, null: false, foreign_key: true
      t.float :value, null: false

      t.timestamps
    end
  end
end
