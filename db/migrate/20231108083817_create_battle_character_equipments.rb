class CreateBattleCharacterEquipments < ActiveRecord::Migration[7.0]
  def change
    create_table :battle_character_equipments do |t|

      t.timestamps
    end
  end
end
