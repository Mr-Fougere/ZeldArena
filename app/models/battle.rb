class Battle < ApplicationRecord
  enum status: { pending: 0, ongoing: 1, finished: 2 }

  belongs_to :winner_battle_character, class_name: 'BattleCharacter', optional: true, inverse_of: :battle_won
  has_many :battle_characters, dependent: :destroy
  has_many :battle_actions, dependent: :destroy

  accepts_nested_attributes_for :battle_characters, allow_destroy: true

  def winner_update
    update(winner_battle_character: battle_actions.hitted.last.attacker)
  end
end
