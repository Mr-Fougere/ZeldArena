class CreateBattleCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :battle_characters do |t|
      t.float :current_health_points, null: false
      t.float :current_attack_power, null: false
      t.float :current_armor_points, null: false
      t.float :current_speed, null: false
      t.float :critical_hit_rate, null: false
      t.float :dodge_rate, null: false
      t.float :miss_rate, null: false
      t.float :critical_multiplier, null: false

      t.references :character, null: false, foreign_key: true
      t.references :battle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
