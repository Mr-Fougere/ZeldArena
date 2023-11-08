class Battle < ApplicationRecord
  enum status: { pending: 0, ongoing: 1, finished: 2 }

end
