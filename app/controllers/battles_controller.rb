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
    BattleSimulator.new(battle: battle).perform if battle.save
  end

  def update_ui
    render turbo_stream: update_slot(params[:turbo_frame_id], params[:value])
  end

  private

  def battle_params
    params.require(:battle).permit(:name, battle_characters_attributes: [:id, :character_id,
                                                                         { battle_character_equipments_attributes: %i[id equipment_id] }])
  end

  def append_battle_history
  
  end

  def update_slot(turbo_frame_id, value)
    slot_type = turbo_frame_id.split('-').first
    data = find_data(slot_type, value)

    return turbo_stream.update(turbo_frame_id, partial: 'elements/filled_slot', locals: { data: data }) if data

    empty_image = find_image(slot_type)
    classes = turbo_frame_id[-1] == 'L' ? 'reverse' : ''
    turbo_stream.update(turbo_frame_id, partial: 'elements/empty_slot',
                                        locals: { classes: classes, image: empty_image })
  end

  def find_data(slot_type, value)
    case slot_type
    when 'equipment'
      Equipment.find(value) if value.present?
    when 'character'
      Character.find(value) if value.present?
    end
  end

  def find_image(slot_type)
    case slot_type
    when 'equipment'
      'hand'
    when 'character'
      'empty_pp'
    end
  end
end
