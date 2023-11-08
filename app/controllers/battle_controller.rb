# frozen_string_literal: true
class BattlesController < ApplicationController
  def index
    @battles = Battle.finished
  end

  def new

  end

  private

  def battle_params
    params.require(:battle).permit(character_battles_attributes: [:character_id, :_destroy,
                                                                  :'character_battle_equipments_attributes:', :'%i[equipment_id', :'_destroy]'])
  end
end
