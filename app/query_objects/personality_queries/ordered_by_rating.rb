module PersonalityQueries
  class OrderedByRating
    def initialize(relation = Personality.all)
      @relation = relation
    end

    def call
      @relation
        .joins(:rates)
        .group(:personality_id)
        .order('avg(personality_rates.value) desc')
    end
  end
end
