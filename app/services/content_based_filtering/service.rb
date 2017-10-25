module ContentBasedFiltering
  class Service
    PERSONALITY_TYPE = Personality.name.downcase
    AVAILABLE_TYPES = Content::TYPES + [PERSONALITY_TYPE]

    def initialize
      @content_recommendation_fetcher = ContentBasedFiltering::ContentRecommendationsFetcher.new
      @personality_recommendation_fetcher = ContentBasedFiltering::PersonalityRecommendationsFetcher.new
    end

    def get_filtered_data(user, items_types = nil)
      items_types = filter_items_types(items_types)
      filtered_data_for_types(user, items_types)
    end

    #TODO: updaters, unlike fetcher, scattered across various servise-updaters outside module
    #TODO: module has too complicated and unreadable public interface
    #TODO: maybe find the way to unify updaters - see Readme

    private

    #TODO: find the way to reuse

    def filtered_data_for_types(user, items_types)
      items_types.inject({}) do |filtered_data, items_type|
        recommendations_fetcher = set_recommendations_fetcher(items_type)
        recommendations = recommendations_fetcher.recommendations_data(user, items_type)
        filtered_data.merge({ items_type => recommendations })
      end
    end

    def set_recommendations_fetcher(items_type)
      return @content_recommendation_fetcher if Content.content_type? items_type
      return @personality_recommendation_fetcher if items_type == PERSONALITY_TYPE
      nil
    end

    def check_single_type(type)
      notice_about_incorrect_types([type])
      AVAILABLE_TYPES.include? type
    end

    def filter_items_types(raw_items_types)
      return AVAILABLE_TYPES if raw_items_types == nil
      notice_about_incorrect_types(raw_items_types)
      raw_items_types & AVAILABLE_TYPES
    end

    def notice_about_incorrect_types(raw_items_types)
      incorrect_types = raw_items_types - AVAILABLE_TYPES
      incorrect_types.each do |incorrect_type|
        Rails.logger.info("#{incorrect_type} is not valid items type for generate content-based recommendations")
      end
    end
  end
end
