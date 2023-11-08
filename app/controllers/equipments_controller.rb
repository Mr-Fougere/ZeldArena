# frozen_string_literal: true
class EquipmentsController < ApplicationController
  def index
    @equipments = Equipment.all.order(unlocked: :desc)
  end
end
