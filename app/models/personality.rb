class Personality < ApplicationRecord
  include Rateable

  has_and_belongs_to_many :content
  has_many :rates, class_name: "PersonalityRate", dependent: :destroy
end
