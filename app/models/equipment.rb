class Equipment < ApplicationRecord
  include Handable
  
  has_many :equipment_effects, dependent: :destroy
end
