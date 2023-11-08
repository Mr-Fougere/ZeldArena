class CreateEffects < ActiveRecord::Migration[7.0]
  def change
    create_table :effects do |t|
      t.string :name, null: false
      t.integer :affected_stat, default: 0, null: false
      t.integer :affected_type, default: 0, null: false

      t.timestamps
    end
  end
end
