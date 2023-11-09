# frozen_string_literal: true
class CharactersController < ApplicationController
  def index
    @characters = Character.all
  end

  def create
    character = Character.new(character_params)
    render turbo_stream: [reset_new_character, append_characters(character)] if character.save
  end

  def destroy
    character = Character.find(params[:id])
    character.destroy
    render turbo_stream: delete_character(character)
  end

  def update
    character = Character.find(params[:id])
    return unless character.update(character_params)

    render turbo_stream: [update_character(character)]
  end

  def edit
    character = Character.find(params[:id])
    return unless character

    render turbo_stream: edit_character(character)
  end

  private

  def update_character(character)
    turbo_stream.replace("character-#{character.id}", partial: 'character', locals: { character: character })
  end

  def reset_new_character
    turbo_stream.update('new-character', partial: 'new_character')
  end

  def append_characters(character)
    turbo_stream.append('characters-list', partial: 'character', locals: { character: character })
  end

  def delete_character(character)
    turbo_stream.remove("character-#{character.id}")
  end

  def edit_character(character)
    turbo_stream.update("character-#{character.id}", partial: 'edit_character', locals: { character: character })
  end

  def character_params
    params.require(:character).permit(:name, :attack_power, :armor_points, :health_points, :speed, :profile_picture)
  end
end
