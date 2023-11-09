class Equipment < ApplicationRecord
  enum position: { right_hand: 0, left_hand: 1 }

  has_many :equipment_effects, dependent: :destroy
  has_one_attached :image
  has_many :effects, through: :equipment_effects

  accepts_nested_attributes_for :equipment_effects, allow_destroy: true
end
