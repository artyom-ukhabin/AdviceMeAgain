module ContentQueries
  class OrderedByLikedPersonalities
    def initialize(current_user, relation = Content.all)
      @relation = relation
      @current_user = current_user
    end

    def call
      Content
        .select('*')
        .from(
          @relation
            .joins(personalities: :rates)
            .where('personality_rates.user_id = ?', @current_user.id)
            .where('personality_rates.value IN (?)', PersonalityRate::HIGH_RATES)
            .order('personality_rates.value desc', 'content_personalities.personality_id')
        ).distinct
    end
  end
end
