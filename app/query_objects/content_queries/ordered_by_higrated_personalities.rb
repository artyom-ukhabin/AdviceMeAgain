module ContentQueries
  class OrderedByHigratedPersonalities
    def initialize(relation = Content.all)
      @relation = relation
    end

    def call
      Content
        .select('*')
        .from(
          @relation
            .joins(personalities: :rates)
            .group('personality_rates.personality_id, content_personalities.content_id')
            .having('avg(personality_rates.value) IN (?)', PersonalityRate::HIGH_RATES)
            .order('avg(personality_rates.value) desc', 'content_personalities.personality_id')
        ).distinct
    end
  end
end
