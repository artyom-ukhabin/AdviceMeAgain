module RecommendationsDecorators
  class RecommendedContentDecorator
    RECOMMENDATIONS_METHODS = %i(highest_rated most_discussed most_mentioned
      with_highrated_related_personalities)

    def initialize(items_type)
      @items_type = items_type
      @collaborations_service = set_collaborations_service(@items_type)
      @recommendations_aggregator = set_recommendations_aggregator(@items_type)
      define_recommendations_methods(@recommendations_aggregator)
    end

    def recommendations_data(user)
      recommendations_data = {}
      recommendations_data[:type] = @items_type.capitalize.pluralize
      recommendations_data[:collaborations_data] = get_collaboration_data(user)
      recommendations_data[:other_recommendations] = other_recommendations_data(user)
      recommendations_data
    end

    private

    def set_collaborations_service(type)
      Collaborations::Service.new([type])
    end

    def set_recommendations_aggregator(type)
      QueriesAggregators::ContentRecommendationsAggregator.new(type)
    end

    def get_collaboration_data(user)
      @collaborations_service.get_collaboration_data(user)[@items_type]
    end

    def other_recommendations_data(user)
      other_recommendations_data = []
      other_recommendations_data += regular_methods_data
      other_recommendations_data << with_liked_related_personalities(user)
    end

    def regular_methods_data
      RECOMMENDATIONS_METHODS.inject([]) do |regular_methods_data, method_name|
        regular_methods_data << send(method_name)
      end
    end

    def with_liked_related_personalities(user)
      regular_recommendations = {}
      regular_recommendations[:recommendation_name] = __method__.to_s.humanize
      regular_recommendations[:recommendation_items] = @recommendations_aggregator.with_liked_related_personalities(user)
      regular_recommendations
    end

    #TODO: \/\/\/ helpful duplication, start rearchitecture from here

    def define_recommendations_methods(recommendations_aggregator)
      class_eval do
        RECOMMENDATIONS_METHODS.each do |method_name|
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