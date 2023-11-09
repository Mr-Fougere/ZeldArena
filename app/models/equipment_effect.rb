class EquipmentEffect < ApplicationRecord
  belongs_to :equipment
  belongs_to :effect

  def value_effect
    multiplier = effect.positive? ? 1 : -1
    value * multiplier
  end
end
