class Personality < ApplicationRecord
  TYPE = self.name.downcase

  include Rateable

  has_and_belongs_to_many :content
  #TODO: add association for every content type maybe
  has_many :reviews, class_name: 'PersonalityReview', dependent: :destroy
  has_many :rates, class_name: "PersonalityRate", dependent: :destroy
  has_many :rated_users, through: :rates, join_table: 'personality_rates', source: :user

  scope :without_content, ->(content) { where.not(id: content.personality_ids) }
  scope :with_name, ->(name) { where("name like ?", "%#{name}%") }
  scope :ordered_by_name, -> { order(:name) }
  scope :ordered_availables_for_content, ->(content) { without_content(content).ordered_by_name }

  class << self
    #TODO: think
    def token_inputs_for_content(term, content)
      ordered_availables_for_content(content).with_name(term)
    end
  end

  def grouped_content
    content.grouped_by_type
  end

  def grouped_content_with_types(types)
    content.grouped_by_type_for_types(types)
  end

  #TODO: refactor
  def full_grouped_content
    types = Content::TYPES.map(&:capitalize)
    complete_grouped_hash(types, grouped_content)
  end

  def full_grouped_content_with_types(types)
    types = types.map(&:capitalize)
    complete_grouped_hash(types, grouped_content_with_types(types))
  end

  def related_content_types
    content.distinct_types
  end

  def type
    TYPE.capitalize
  end

  private

  def complete_grouped_hash(types, grouped_hash)
    types.each do |content_type|
      grouped_hash.merge!({ content_type => [] }) unless grouped_hash.has_key? content_type
    end
    grouped_hash
  end
end
