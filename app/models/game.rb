class Game < Content
  has_and_belongs_to_many :platforms, foreign_key: 'content_id'
  has_and_belongs_to_many :genres, class_name: 'GameGenre', association_foreign_key: 'game_genre_id',
    foreign_key: :content_id

  scope :with_genre_name, ->(genre_name) { joins(:genres).where('game_genres.name = ?', genre_name) }
  scope :without_genre, ->(genre) { where.not(id: genre.content_ids) }
  scope :ordered_availables_for_genre, ->(genre) { without_personality(genre).ordered_by_name }

  class << self
    def token_inputs_for_genre(term, genre)
      ordered_availables_for_genre(genre).with_name(term)
    end
  end
end
