class Album < ApplicationRecord
  belongs_to :band, foreign_key: 'content_id'
  has_many :tracks
end
