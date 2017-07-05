class Content < ApplicationRecord
  include Rateable
  
  TYPES = %w(book movie game band)
  #TODO: think about not nil constraint or validation
  has_and_belongs_to_many :personalities
  has_and_belongs_to_many :posts
  has_many :reviews, class_name: 'ContentReview', dependent: :destroy
  has_many :rates, class_name: 'ContentRate', dependent: :destroy
end
