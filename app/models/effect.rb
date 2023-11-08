class Effect < ApplicationRecord
  enum affected_stat: { health_points: 0, attack_power: 1, armor_points: 2, speed: 3 }

  has_many :equipment_effects, dependent: :destroy
end
