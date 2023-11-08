class CreateBattles < ActiveRecord::Migration[7.0]
  def change
    create_table :battles do |t|
      t.integer :status, default: 0
      t.references :winner_character, null: true, foreign_key: { to_table: :characters }
      t.timestamps
    end
  end
end
