class CreateBattleCharacterEquipments < ActiveRecord::Migration[7.0]
  def change
    create_table :battle_character_equipments do |t|
      t.references :battle_character, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
