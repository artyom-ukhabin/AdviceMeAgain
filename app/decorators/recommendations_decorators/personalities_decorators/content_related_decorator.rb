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

      #TODO: refactor more - learn more about block and metacode
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

      private

      def set_recommendations_aggregator
        QueriesAggregators::PersonalityRecommendationsAggregator.new
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
    end
  end
end