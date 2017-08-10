class Profile < ApplicationRecord
  belongs_to :user

  def changeable_by?(user)
    self.user == user || user.admin?
  end
end
