class Band < Content
  has_many :albums, foreign_key: 'content_id'
end
