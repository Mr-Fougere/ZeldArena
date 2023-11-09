class Battle < ApplicationRecord
  enum status: { pending: 0, ongoing: 1, finished: 2 }
  
  belongs_to :winner_battle_character, class_name: 'BattleCharacter', optional: true, inverse_of: :battles_won
  has_many :battle_characters, dependent: :destroy

  accepts_nested_attributes_for :battle_characters, allow_destroy: true
end
