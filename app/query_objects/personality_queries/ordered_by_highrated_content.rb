module PersonalityQueries
  class OrderedByHighratedContent
    def initialize(content_type, relation = Personality.all)
      @relation = relation
      @content_type = content_type
    end

    #TODO: break into methods?
    def call
      Personality
        .select('*')
        .from(
          @relation
            .joins(content: :rates)
            .where('content.type = ?', @content_type)
            .group('content_rates.content_id, content_personalities.personality_id')
            .having('avg(content_rates.value) IN (?)', ContentRate::HIGH_RATES)
            .order('avg(content_rates.value) desc', 'content_personalities.content_id')
        ).distinct
    end
  end
end
