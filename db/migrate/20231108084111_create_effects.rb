class CreateEffects < ActiveRecord::Migration[7.0]
  def change
    create_table :effects do |t|
      t.integer :affected_stat, default: 0, null: false
      t.float :value, null: false
      t.boolean :is_percentage, default: false

      t.timestamps
    end
  end
end
