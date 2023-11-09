# frozen_string_literal: true
class BattleSimulator
  def initialize(battle:)
    raise TypeError unless battle.is_a?(Battle)

    @battle = battle
  end

  def perform
    p 'BattleSimulator#perform'
  end
end
