class CreateBattleActions < ActiveRecord::Migration[7.0]
  def change
    create_table :battle_actions do |t|
      t.float :damage, null: false, default: 0
      t.integer :result, null: false, default: 0
      t.references :battle, null: false, foreign_key: true

      t.references :attacker, null: false, foreign_key: { to_table: :battle_characters }
      t.references :defender, null: false, foreign_key: { to_table: :battle_characters }

      t.timestamps
    end
  end
end
