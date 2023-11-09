# frozen_string_literal: true
class Character < ApplicationRecord
  BASE_EXPERIENCE = 10
  GROWTH_FACTOR = 1.5

  has_one_attached :profile_picture

  has_many :battle_characters, dependent: :destroy
  has_many :battles, through: :battle_characters

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :health_points, inclusion: 10..30
  validates :attack_power, inclusion: 0.5..5
  validates :armor_points, inclusion: 0..20
  validates :speed, inclusion: 1..10
  validates :experience_points, numericality: { greater_than_or_equal_to: 0 }

  scope :balanced, -> { filter { |character| character.character_balance == :balanced } }

  def death_rate
    battles.empty? ? 0 : ((1- win_count.to_f / battles.uniq.count ).round(2) * 100).to_i
  end

  def win_count
    battles_won.count
  end

  def battles_won
    battles.where(winner_battle_character_id: battle_characters.pluck(:id)).uniq
  end

  def character_balance
    total_stat = health_points + attack_power + armor_points + speed
    if total_stat > 35 && average_damage_per_second > 1.0
      :too_strong
    elsif total_stat < 30 || average_damage_per_second <= 0.5
      :too_weak
    else
      :balanced
    end
  end

end
