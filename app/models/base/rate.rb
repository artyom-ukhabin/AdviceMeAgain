module Base
  class Rate < ApplicationRecord
    self.abstract_class = true

    belongs_to :user

    scope :for_user, ->(user) { where(user_id: user.to_param) }
  end
end