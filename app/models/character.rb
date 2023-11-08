# frozen_string_literal: true
class Character < ApplicationRecord
  BASE_EXPERIENCE = 10
  GROWTH_FACTOR = 1.5

  has_one_attached :profile_picture

  validates :name, presence: true, length: { minimum: 4, maximum: 30 }
  validates :health_points, inclusion: 10..30
  validates :attack_power, inclusion: 0.5..5
  validates :armor_points, inclusion: 0..20
  validates :speed, inclusion: 1..10
  validates :experience_points, numericality: { greater_than_or_equal_to: 0 }

  scope :balanced, -> { filter { |character| character.character_balance == :balanced } }

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

  def death_rate
    0.0
  end

  def win_count
    0.0
  end

  def average_damage_per_second
    attack_power / speed
  end

end
