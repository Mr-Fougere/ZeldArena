# frozen_string_literal: true
class BattleCharacter < ApplicationRecord
  belongs_to :battle
  belongs_to :character

  BLACKLISTED_ATTRIBUTES = %w[id name experience_points created_at updated_at].freeze

  has_many :battle_character_equipments, dependent: :destroy
  has_many :equipments, through: :battle_character_equipments
  has_many :equipment_effects, through: :equipments
  has_one :battle_won, class_name: 'Battle', foreign_key: 'winner_battle_character_id',
                       inverse_of: :winner_battle_character, dependent: :destroy
  has_many :attack_actions, class_name: 'BattleAction', foreign_key: 'attacker_id', inverse_of: :attacker,
                            dependent: :destroy
  has_many :defense_actions, class_name: 'BattleAction', foreign_key: 'defender_id', inverse_of: :defender,
                             dependent: :destroy

  accepts_nested_attributes_for :battle_character_equipments, allow_destroy: true

  before_create :set_initial_stats

  def set_initial_stats
    character.attributes.each do |key, value|
      next if BLACKLISTED_ATTRIBUTES.include?(key)

      self[key] = value
    end
  end

  def apply_equipment_effects
    equipment_effects.each do |equipment_effect|
      self[equipment_effect.effect.affected_stat] += equipment_effect.value_effect
    end
    save
  end

  def speed_attack
    ((1.0 / (attack_power * speed)) * 100).round
  end

  def critical_hit
    critical_hit_multiplier * attack_power
  end

  def critical_hit?
    roll(critical_hit_rate)
  end

  def dodge?
    roll(dodge_rate)
  end

  def miss?
    roll(miss_rate)
  end

  def increase_stat(stat, multiplier)
    self[stat] += define_value(stat) * multiplier
    save
  end

  def decrease_stat(stat, multiplier)
    self[stat] -= define_value(stat) * multiplier
    save
  end

  private

  def define_value(stat)
    case stat
    when 'critical_hit_rate'
      2
    when 'dodge_rate', 'miss_rate'
      0.5
    when 'critical_hit_multiplier'
      0.1
    else
      1
    end
  end

  def roll(rate)
    random_number = rand(101)
    random_number <= rate
  end
end
