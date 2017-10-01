module RecommendationsDecorators
  module PersonalitiesDecorators
    class RegularDecorator
      RECOMMENDATIONS_METHODS = %i(highest_rated most_discussed)

      def initialize
        @recommendations_aggregator = set_recommendations_aggregator
        define_recommendations_methods(@recommendations_aggregator)
      end

      def recommendations_data
        RECOMMENDATIONS_METHODS.inject([]) do |regular_recommendations_data, method_name|
          regular_recommendations_data << public_send(method_name)
        end
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

      private

      def set_recommendations_aggregator
        QueriesAggregators::PersonalityRecommendationsAggregator.new
      end
    end
  end
end