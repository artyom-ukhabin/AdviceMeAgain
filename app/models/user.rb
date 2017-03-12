class User < ApplicationRecord
  enum role: [:regular, :moderator, :admin]
  before_save :set_default_role

  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         #:confirmable, TODO: enable later
         :recoverable, :rememberable, :trackable, :validatable
  has_one :profile

  private

  def set_default_role
    self.role ||= :regular
  end
end
