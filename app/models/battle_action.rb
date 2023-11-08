class BattleAction < ApplicationRecord
  belongs_to :battle
  belongs_to :attacker, class_name: 'BattleCharacter'
  belongs_to :defender, class_name: 'BattleCharacter'
end
