# frozen_string_literal: true
class BattleCharacter < ApplicationRecord
  belongs_to :battle
  belongs_to :character
end
