# frozen_string_literal: true
class EquipmentsController < ApplicationController
  def index
    @equipments = Equipment.all
  end
end
