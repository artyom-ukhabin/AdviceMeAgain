module RecommendationsDecorators
  class RecommendedPersonalitiesDecorator
    PERSONALITY_TYPE = Personality.name.downcase
    REGULAR_RECOMMENDATIONS_METHODS = %i(highest_rated most_discussed)
    CONTENT_RELATED_RECOMMENDATIONS_METHODS = %i(with_highrated_related_content with_liked_related_content)

    def initialize
      @collaborations_service = set_collaborations_service(PERSONALITY_TYPE)
      @recommendations_aggregator = set_recommendations_aggregator
      define_regular_recommendations_methods(@recommendations_aggregator)
    end

    def recommendations_data(user)
      recommendations_data = {}
      recommendations_data[:collaborations_data] = get_collaboration_data(user)
      recommendations_data[:regular_recommendations] = regular_data
      recommendations_data[:content_related_recommendations] = content_related_data(user)
      recommendations_data
    end

    private

    def set_collaborations_service(type)
      Collaborations::Service.new([type])
    end

    def set_recommendations_aggregator
      QueriesAggregators::PersonalityRecommendationsAggregator.new
    end

    def get_collaboration_data(user)
      @collaborations_service.get_collaboration_data(user)[PERSONALITY_TYPE]
    end

    def content_related_data(user)
      content_related_data = []
      content_related_data << with_highrated_related_content
      content_related_data << with_liked_related_content(user)
    end

    def regular_data
      REGULAR_RECOMMENDATIONS_METHODS.inject([]) do |regular_recommendations_data, method_name|
        regular_recommendations_data << send(method_name)
      end
    end

    #TODO: definitely need 3 different classes for each operations set
    #TODO: and refactor more - learn more about block and metacode
    def with_highrated_related_content
      name = __method__.to_s.humanize
      collection = build_highrated_content_recommendations
      decorate_content_related_collection(name, collection)
    end

    def with_liked_related_content(user)
      name = __method__.to_s.humanize
      collection = build_liked_content_recommendations(user)
      decorate_content_related_collection(name, collection)
    end

    def build_highrated_content_recommendations
      Content::TYPES.inject([]) do |recommendation_collection, content_type|
        items = @recommendations_aggregator.with_highrated_related_content(content_type)
        recommendation_collection << decorate_content_related_hash(content_type, items)
      end
    end

    def build_liked_content_recommendations(user)
      Content::TYPES.inject([]) do |recommendation_collection, content_type|
        items = @recommendations_aggregator.with_liked_related_content(user, content_type)
        recommendation_collection << decorate_content_related_hash(content_type, items)
      end
    end

    def decorate_content_related_collection(name, collection)
      personality_data = {}
      personality_data[:recommendation_name] = name
      personality_data[:recommendation_collection] = collection
      personality_data
    end

    def decorate_content_related_hash(content_type, items)
      single_type_hash = {}
      single_type_hash[:type] = content_type.capitalize.pluralize
      single_type_hash[:items] = items
      single_type_hash
    end

    #TODO: \/\/\/ helpful duplication, start rearchitecture from here

    def define_regular_recommendations_methods(recommendations_aggregator)
      class_eval do
        REGULAR_RECOMMENDATIONS_METHODS.each do |method_name|
          define_method method_name do
            regular_recommendations = {}
            regular_recommendations[:recommendation_name] = method_name.to_s.humanize
            regular_recommendations[:recommendation_items] = @recommendations_aggregator.public_send(method_name)
            regular_recommendations
          end
        end
      end
    end
  end
end