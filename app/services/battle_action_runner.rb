# frozen_string_literal: true
class BattleActionRunner
  def initialize(battle_action:)
    raise TypeError unless battle_action.is_a?(BattleAction)

    @battle_action = battle_action
    @attacker = battle_action.attacker
    @defender = battle_action.defender
    @damage = @attacker.attack_power
    @result = :hit
    @health_points_lose = 0
    @armor_points_lose = 0
  end

  def perform
    roll_action_result
    apply_damage if @result == :hit || @result == :critical_hit
    apply_after_action_effects
    update_battle_action
    @battle_action.battle.finished! if @defender.health_points <= 0
  end

  private

  def roll_action_result
    if @attacker.critical_hit?
      @damage = @attacker.critical_hit
      @result = :critical_hit
    end
    @result = :miss if @attacker.miss?
    @result = :dodged if @defender.dodge? && @result != :miss
  end

  def apply_after_action_effects
    @defender.increase_stat('critical_hit_multiplier', @health_points_lose) if @health_points_lose.positive?
    return unless @armor_points_lose.positive?

    @defender.increase_stat('dodge_rate', @armor_points_lose)
    @attacker.increase_stat('critical_hit_rate', @armor_points_lose)
    @defender.increase_stat('critical_hit_multiplier', @armor_points_lose)
  end

  def apply_damage
    remaining_damage = @damage - @defender.armor_points
    if remaining_damage.positive?
      @defender.health_points -= remaining_damage
      @health_points_lose = remaining_damage
      @armor_points_lose = @defender.armor_points
      @defender.armor_points = 0
    else
      @defender.armor_points -= @damage
      @armor_points_lose = @damage
    end
    @defender.save
  end

  def update_battle_action
    @battle_action.update(damage: @damage, result: @result)
  end
end
