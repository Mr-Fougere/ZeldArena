class Battle < ApplicationRecord
  enum status: { pending: 0, ongoing: 1, finished: 2 }
  
  belongs_to :winner_character, class_name: 'Character', optional: true, inverse_of: :battles_won
  has_many :battle_characters, dependent: :destroy
end