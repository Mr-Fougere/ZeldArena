# frozen_string_literal: true
class BattlesController < ApplicationController
  def index
    @battles = Battle.finished
  end

  def new
    @battle = Battle.new
    2.times { @battle.battle_characters.build }
    @battle.battle_characters.each do |battle_character|
      2.times { battle_character.battle_character_equipments.build }
    end
  end

  def create
    battle = Battle.new(battle_params)
    if battle.save
      BattleSimulator.new(battle: battle).launch
    else
      render :new
    end
  end

  private

  def battle_params
    params.require(:battle).permit(:name, battle_characters_attributes: [:id, :character_id,
                                                                         { battle_character_equipments_attributes: %i[id equipment_id] }])
  end

end
