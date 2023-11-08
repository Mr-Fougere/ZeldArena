# frozen_string_literal: true
class CharactersController < ApplicationController

    def index
        @characters = Character.all
    end

    def create
        character = Character.new(character_params)
        if character.save
            render turbo_stream: [reset_new_character, append_characters(character)]
        else
            render :new
        end
    end

    def destroy
        character = Character.find(params[:id])
        character.destroy
        render turbo_stream: delete_character(character)
    end

    def update
    end

    def edit
    end

    private

    def reset_new_character
        turbo_stream.update('new-character', partial: 'new_character')
    end

    def append_characters(character)
        turbo_stream.append('characters-list', partial: 'character', locals: { character: character })
    end

    def delete_character(character)
        turbo_stream.remove("character-#{character.id}")
    end

    def character_params
      params.require(:character).permit(:name, :attack_power, :armor_points,:health_points, :speed, :profile_picture)
    end
end
