module Base
  class Rate < ApplicationRecord
    self.abstract_class = true

    LOW_RATES = (1..2)
    HIGH_RATES = (3..5)

    belongs_to :user

    scope :for_user, ->(user) { where(user_id: user.to_param) }
  end
end