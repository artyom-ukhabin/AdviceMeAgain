class Content < ApplicationRecord
  include Rateable

  TYPES = %w(book movie game band)

  #TODO: think about not nil constraint or validation
  has_and_belongs_to_many :personalities
  has_many :content_posts
  has_many :posts, through: :content_posts
  has_many :reviews, class_name: 'ContentReview', dependent: :destroy
  has_many :rates, class_name: 'ContentRate', dependent: :destroy
  has_many :rated_users, through: :rates, join_table: 'content_rates', source: :user

  scope :with_name, ->(name) { where("name like ?", "%#{name}%") }
  scope :ordered_by_name, -> { order(:name) }
  scope :by_name, ->(name) { where('name = ?', name).first }
  scope :ordered_by_content_post_position, -> { joins(:content_posts).order('content_posts.position') }
  scope :for_post, ->(post) { joins(:content_posts).where('content_posts.post_id = ?', post.id)  }
  #TODO: refactor: find the way to move scopes with different responsibilities
  scope :without_personality, ->(personality) { where.not(id: personality.content_ids) }
  scope :ordered_availables_for_personality, ->(personality) { without_personality(personality).ordered_by_name }

  class << self
    def check_type(type)
      type if content_type?(type)
    end

    def content_type?(type)
      TYPES.include?(type)
    end

    #TODO: think about names for this method and scopes
    #TODO: 'searchable' logic, think how reuse it
    def autocomplete_data(term)
      with_name(term).ordered_by_name.pluck(:name)
    end

    #TODO: check why its possible to use with scopes correctly
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

    #TODO: think
    def token_inputs_for_personality(personality, term)
      ordered_availables_for_personality(personality).with_name(term)
    end

    def filter_content_types(types)
      types & TYPES
    end
  end
end
