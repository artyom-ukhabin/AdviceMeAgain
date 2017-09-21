module QueriesAggregators
  class ContentRecommendationsAggregator
    def initialize(items_type)
      @items_type = items_type
      @actual_relation = build_actual_type_relation(@items_type)
    end

    def highest_rated
      ContentQueries::OrderedByRating.new(@actual_relation).call
    end

    def most_discussed
      ContentQueries::OrderedByReviews.new(@actual_relation).call
    end

    def most_mentioned
      ContentQueries::OrderedByPosts.new(@actual_relation).call
    end

    def with_highrated_related_personalities
      ContentQueries::OrderedByHigratedPersonalities.new(@actual_relation).call
    end

    def with_liked_related_personalities(user)
      ContentQueries::OrderedByLikedPersonalities.new(user, @actual_relation).call
    end

    private

    def build_actual_type_relation(items_type)
      Content.where(type: items_type)
    end
  end
end
