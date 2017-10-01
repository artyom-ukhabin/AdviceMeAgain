module RandomRecommendation
  class Fetcher
    DEFAULT_TYPES = Content::TYPES + [Personality::TYPE]

    def initialize(recommendations_types = nil)
      @recommendations_types = set_recommendations_types(recommendations_types)
      @content_unifier = RandomRecommendation::ContentRecommendationsUnifier
      @personalities_unifier = RandomRecommendation::PersonalitiesRecommendationsUnifier
    end

    def get_recommendation(user)
      type = get_random_type
      unifier = set_recommendations_unifier(type)
      method = get_random_method(unifier)
      result = unifier.public_send(method, user)
      { type: type.pluralize.humanize, result: result }
    end

    private

    def get_random_type
      @recommendations_types.sample
    end



    #TODO: maybe move - question of responsibility
    #TODO: actually both fetcher and unifier needed for each type to get rid of dependency
    def get_random_method(unifier)
      unifier.class::RECOMMENDATIONS_METHODS.sample
    end

    def set_recommendations_types(recommendations_types)
      return DEFAULT_TYPES if recommendations_types.blank?
      DEFAULT_TYPES & recommendations_types
    end

    def set_recommendations_unifier(type)
      return @content_unifier.new(type) if Content.content_type?(type)
      @personalities_unifier.new if type == Personality::TYPE
    end
  end
end