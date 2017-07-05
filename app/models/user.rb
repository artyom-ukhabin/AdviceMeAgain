class User < ApplicationRecord
  enum role: [:regular, :moderator, :admin]
  before_save :set_default_role

  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         #:confirmable, TODO: enable later
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :posts, dependent: :destroy

  private

  def set_default_role
    self.role ||= :regular
  end
end
