# frozen_string_literal: true
class BattleSimulator
  def initialize(battle: Battle)
    @battle = battle
  end

  def perform
    p 'BattleSimulator#perform'
  end
end
