module PersonalityQueries
  class OrderedByLikedContent
    def initialize(current_user, content_type, relation = Personality.all)
      @relation = relation
      @current_user = current_user
      @content_type = content_type
    end

    def call
      Personality
        .select('*')
        .from(
          @relation
            .joins(content: :rates)
            .where('content.type = ?', @content_type)
            .where('content_rates.user_id = ?', @current_user.id)
            .where('content_rates.value IN (?)', ContentRate::HIGH_RATES)
            .order('content_rates.value desc', 'content_personalities.content_id')
        ).distinct
    end
  end
end
