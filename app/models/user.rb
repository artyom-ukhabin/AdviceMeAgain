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
  has_many :rated_content, through: :content_rates, source: :content
  has_many :personality_rates, dependent: :destroy
  has_many :rated_personalities, through: :personality_rates, source: :personality
  has_many :content_reviews, dependent: :destroy
  has_many :personality_reviews, dependent: :destroy
  has_many :authored_posts, class_name: 'Post', foreign_key: 'author_id', dependent: :nullify
  has_and_belongs_to_many :published_posts, class_name: 'Post', association_foreign_key: 'post_id', dependent: :nullify
  has_and_belongs_to_many :liked_posts, class_name: 'Post', join_table: 'posts_users_likes', association_foreign_key: 'post_id'

  def ids_for_rated_content(type = nil)
    type ? rated_content.ids_for_type(type) : rated_content_ids
  end

  #TODO: URGENT: move away
  def can_repost?(post)
    !(authored_posts.include?(post) || published_posts.include?(post))
  end

  def have_moderator_rights?
    moderator? || admin?
  end

  def personalities_content_types
    rated_personalities.inject([]) do |related_personalities_types, personality|
      related_personalities_types | personality.related_content_types
    end
  end

  private

  def set_default_role
    self.role ||= :regular
  end
end
