class Game < Content
  has_and_belongs_to_many :platforms, foreign_key: 'content_id'
end
