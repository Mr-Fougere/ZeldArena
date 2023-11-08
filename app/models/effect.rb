class Effect < ApplicationRecord
  enum affected_stat: { health_points: 0, attack_power: 1, armor_points: 2, speed: 3, critical_hit_rate: 4,
                        critical_hit_multiplier: 5, dodge_rate: 6, miss_rate: 7 }

  enum affected_type: { negative: 0, positive: 1 }

  has_many :equipment_effects, dependent: :destroy

  def percent?
    affected_stat.in? %w[critical_hit_rate dodge_rate miss_rate]
  end
end
