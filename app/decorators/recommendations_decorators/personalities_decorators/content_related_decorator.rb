module RecommendationsDecorators
  module PersonalitiesDecorators
    class ContentRelatedDecorator
      def initialize
        @recommendations_aggregator = set_recommendations_aggregator
      end

      def recommendations_data(user)
        recommendations_data = []
        recommendations_data << with_highrated_related_content
        recommendations_data << with_liked_related_content(user)
      end

      def with_highrated_related_content
        related_content_data(__method__) do |content_type|
          @recommendations_aggregator.with_highrated_related_content(content_type)
        end
      end

      def with_liked_related_content(user)
        related_content_data(__method__) do |content_type|
          @recommendations_aggregator.with_liked_related_content(user, content_type)
        end
      end

      private

      def set_recommendations_aggregator
        QueriesAggregators::PersonalityRecommendationsAggregator.new
      end

      def related_content_data(method_name, &block)
        name = method_name.to_s.humanize
        #perfomance oriented sending block to another method
        collection = build_content_recommendations(&Proc.new)
        decorate_content_related_collection(name, collection)
      end

      def build_content_recommendations(&block)
        Content::TYPES.inject([]) do |recommendation_collection, content_type|
          items = yield content_type
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
    end
  end
end