# frozen_string_literal: true
class BattleCharacterEquipment < ApplicationRecord
  include Handable

  belongs_to :battle_character
  belongs_to :equipment
end
