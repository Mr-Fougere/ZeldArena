# frozen_string_literal: true
class BattleSimulator
  def initialize(battle:)
    raise TypeError unless battle.is_a?(Battle)

    @battle = battle
    @battle_characters = battle.battle_characters.order(:speed)
    @ticks = 0
    @battle.ongoing!
  end

  def perform
    apply_battle_effect
    while battle_in_progress?
      battle_character_actions
      @ticks += 1
    end
    @battle.winner_update
  end

  private

  def battle_character_actions
    @battle_characters.each do |battle_character|
      next unless (@ticks % battle_character.speed_attack).zero?

      opponent = opponent_of(battle_character)
      new_battle_action = BattleAction.create(battle: @battle, attacker: battle_character, defender: opponent, tick: @ticks)
      BattleActionRunner.new(battle_action: new_battle_action).perform
    end
  end

  def battle_in_progress?
    @ticks < 9999 && @battle.ongoing?
  end

  def opponent_of(battle_character)
    @battle_characters.reject { |bc| bc == battle_character }.first
  end

  def apply_battle_effect
    @battle_characters.each(&:apply_equipment_effects)
    speed_effects
    armor_effects
    attack_speed_effect
  end

  def speed_effects
    faster_character = @battle_characters.max_by(&:speed)
    slower_character = @battle_characters.min_by(&:speed)
    difference = faster_character.speed - slower_character.speed
    faster_character.increase_stat('dodge_rate', difference)
    slower_character.decrease_stat('miss_rate', difference)
  end

  def armor_effects
    @battle_characters.where('armor_points > 0').each do |battle_character|
      battle_character.decrease_stat('dodge_rate', battle_character.armor_points)
      opponent_of(battle_character).decrease_stat('critical_hit_rate', battle_character.armor_points)
    end
  end

  def attack_speed_effect
    @battle_characters.each do |battle_character|
      if battle_character.attack_power > battle_character.speed
        battle_character.increase_stat('miss_rate', battle_character.attack_power - battle_character.speed )
      end
    end
  end
end
