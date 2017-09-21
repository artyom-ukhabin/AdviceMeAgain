module QueriesAggregators
  class PersonalityRecommendationsAggregator
    def highest_rated
      PersonalityQueries::OrderedByRating.new.call
    end

    def most_discussed
      PersonalityQueries::OrderedByReviews.new.call
    end

    def with_highrated_related_content(content_type)
      PersonalityQueries::OrderedByHighratedContent.new(content_type).call
    end

    def with_liked_related_content(user, content_type)
      PersonalityQueries::OrderedByLikedContent.new(user, content_type).call
    end
  end
end
