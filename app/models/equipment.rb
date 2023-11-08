class Equipment < ApplicationRecord
  enum position: { right_hand: 0, left_hand: 1 }
  
  has_many :equipment_effects, dependent: :destroy
end
