class ContentRate < ApplicationRecord
  belongs_to :content
  belongs_to :user

  scope :for_user, ->(user) { where(user_id: user.to_param) }
end
