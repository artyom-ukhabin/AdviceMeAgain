class Content < ApplicationRecord
  include Rateable

  TYPES = %w(book movie game band)

  scope :with_name, ->(name) { where("name like ?", "%#{name}%") }
  scope :ordered_by_name, -> { order(:name) }
  scope :by_name, ->(name) { where('name = ?', name).first }
  scope :ordered_by_content_post_position, -> { joins(:content_posts).order('content_posts.position') }
  scope :for_post, ->(post) { joins(:content_posts).where('content_posts.post_id = ?', post.id)  }

  class << self
    #TODO: think about names for this method and scopes
    def autocomplete_data(term)
      with_name(term).ordered_by_name.map(&:name)
    end

    def grouped_by_type
      all.group_by(&:type)
    end

    def types_amount
      TYPES.length
    end

    #TODO: with knowledge from phase 2 think about these queries
    def data_for_post_table(post)
      for_post(post).ordered_by_content_post_position.grouped_by_type
    end
  end

  #TODO: think about not nil constraint or validation
  has_and_belongs_to_many :personalities
  has_many :content_posts
  has_many :posts, through: :content_posts
  has_many :reviews, class_name: 'ContentReview', dependent: :destroy
  has_many :rates, class_name: 'ContentRate', dependent: :destroy
end
