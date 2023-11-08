# frozen_string_literal: true
class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.float :health_points, default: 30.0
      t.float :attack_power, default: 2.5
      t.float :armor_points, default: 0.0
      t.float :speed, default: 2.5
      t.float :critical_rate, default: 5.0
      t.float :critical_multiplier, default: 1.5
      t.float :dodge_rate, default: 5.0
      t.float :miss_rate, default: 5.0
      t.integer :experience_points, default: 0
      
      t.timestamps
    end
  end
end
