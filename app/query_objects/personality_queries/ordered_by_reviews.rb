module PersonalityQueries
  class OrderedByReviews
    def initialize(relation = Personality.all)
      @relation = relation
    end

    def call
      @relation
        .joins(:reviews)
        .group(:personality_id)
        .order('count(*) desc')
    end
  end
end
