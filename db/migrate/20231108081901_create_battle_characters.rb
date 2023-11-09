class CreateBattleCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :battle_characters do |t|
      t.float :health_points, null: false
      t.float :attack_power, null: false
      t.float :armor_points, null: false
      t.float :speed, null: false
      t.float :dodge_rate, null: false
      t.float :miss_rate, null: false
      t.float :critical_hit_rate, null: false
      t.float :critical_hit_multiplier, null: false
      t.integer :experience_gained, default: 0, null: false
      
      t.references :character, null: false, foreign_key: true
      t.references :battle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
