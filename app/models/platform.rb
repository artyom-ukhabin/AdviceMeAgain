class Platform < ApplicationRecord
  has_and_belongs_to_many :games, association_foreign_key: 'content_id'
end
