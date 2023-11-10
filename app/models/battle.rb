class Battle < ApplicationRecord
  enum status: { hidden: -1, pending: 0, ongoing: 1, finished: 2 }

  WINNER_EXPERIENCE = 10
  CRITICAL_HIT_EXPERIENCE = 5
  DODGE_EXPERIENCE = 5

  belongs_to :winner_battle_character, class_name: 'BattleCharacter', optional: true, inverse_of: :battle_won
  has_many :battle_characters, dependent: :destroy
  has_many :battle_actions, dependent: :destroy

  accepts_nested_attributes_for :battle_characters, allow_destroy: true

  def winner_update
    alive_characters = battle_characters.where('health_points > ?', 0)
    update(winner_battle_character: alive_characters.first) if alive_characters.count == 1
  end

  def grant_experience_points
    battle_characters.each do |battle_character|
      battle_character.experience_gained = evaluate_gain_experience(battle_character)
      battle_character.save
      battle_character.character.gain_experience_points(battle_character.experience_gained)
    end
  end

  def evaluate_gain_experience(battle_character)
    amount = 0
    amount += 10 * battle_character.character.level * (battle_character.winner? ? 1 : 0.2)
    amount += battle_character.attack_actions.critical_hit.count * CRITICAL_HIT_EXPERIENCE * battle_character.character.level
    amount += battle_character.defend_actions.dodged.count * DODGE_EXPERIENCE * battle_character.character.level
  end
end
