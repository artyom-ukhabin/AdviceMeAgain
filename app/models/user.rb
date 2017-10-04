class User < ApplicationRecord
  enum role: [:regular, :moderator, :admin]
  before_save :set_default_role

  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    #:confirmable, TODO: enable later
    :recoverable, :rememberable, :trackable, :validatable

  delegate :name, to: :profile

  has_one :profile, dependent: :destroy
  has_many :content_rates, dependent: :destroy
  has_many :personality_rates, dependent: :destroy
  has_many :content_reviews, dependent: :destroy
  has_many :personality_reviews, dependent: :destroy
  has_many :authored_posts, class_name: 'Post', foreign_key: 'author_id', dependent: :nullify
  has_and_belongs_to_many :published_posts, class_name: 'Post', association_foreign_key: 'post_id', dependent: :nullify
  has_and_belongs_to_many :liked_posts, class_name: 'Post', join_table: 'posts_users_likes', association_foreign_key: 'post_id'

  #TODO: URGENT: move away
  def can_repost?(post)
    !(authored_posts.include?(post) || published_posts.include?(post))
  end

  def have_moderator_rights?
    moderator? || admin?
  end

  private

  def set_default_role
    self.role ||= :regular
  end
end
