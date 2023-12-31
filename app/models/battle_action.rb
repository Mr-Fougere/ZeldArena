class BattleAction < ApplicationRecord
  enum result: { pending: 0, hit: 1, miss: 2, critical_hit: 3, dodged: 4 }

  belongs_to :battle
  belongs_to :attacker, class_name: 'BattleCharacter', inverse_of: :attack_actions
  belongs_to :defender, class_name: 'BattleCharacter', inverse_of: :defend_actions

  scope :hitted, -> { where(result: %w[hit critical_hit]) }
end
