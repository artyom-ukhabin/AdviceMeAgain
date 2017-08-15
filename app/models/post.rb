class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :liked_users, class_name: 'User', join_table: 'posts_users_likes', association_foreign_key: 'user_id'
  has_and_belongs_to_many :publishers, class_name: 'User', association_foreign_key: 'user_id'
  has_many :content_posts, inverse_of: :post #TODO: investigate this
  has_many :content, through: :content_posts

  accepts_nested_attributes_for :content_posts

  #TODO: refactor model in future

  def content_table_data
    Content.data_for_post_table(self)
  end

  def raw_sections_data
    Content.for_post(self).pluck_to_hash(:type, :name, :position)
  end

  def author_profile
    author.profile
  end

  def set_publisher(publisher)
    publishers << publisher
  end

  def delete_publisher(publisher)
    publishers.delete(publisher)
  end

  def repost_owners
    publishers - [author]
  end

  def repost_owners_names
    repost_owners.map(&:name)
  end

  def liked_users_names
    liked_users.map(&:name)
  end

  def changeable_by?(user)
    author == user || user.admin?
  end

  #TODO: in module and polymorphic association if new likeable entity will appear
  #TODO: do something with this obvious abstraction
  def liked_by(user)
    liked_users << user
  end

  def remove_user_like(user)
    liked_users.delete(user) #TODO: destroy?
  end

  def already_liked_by?(user)
    user.liked_posts.include? self
  end

  def liked_users_count
    liked_users.count
  end
end
