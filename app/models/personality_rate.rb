class PersonalityRate < ApplicationRecord
  belongs_to :personality
  belongs_to :user

  scope :for_user, ->(user) { where(user_id: user.to_param) }
end
