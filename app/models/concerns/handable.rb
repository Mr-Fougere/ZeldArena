module Handable
  extend ActiveSupport::Concern

  included do
    enum position: { right_hand: 0, left_hand: 1 }
  end

end
