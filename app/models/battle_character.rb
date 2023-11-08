# frozen_string_literal: true
class BattleCharacter < ApplicationRecord
  belongs_to :battle
  belongs_to :character

  has_many :battle_character_equipments, dependent: :destroy
  has_many :attack_actions, class_name: 'BattleAction', foreign_key: 'attacker_id', inverse_of: :attacker,
                            dependent: :destroy
  has_many :defense_actions, class_name: 'BattleAction', foreign_key: 'defender_id', inverse_of: :defender,
                             dependent: :destroy

  accepts_nested_attributes_for :battle_character_equipments, allow_destroy: true
end
