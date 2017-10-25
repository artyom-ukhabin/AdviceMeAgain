module RecommendationsDecorators
  module Shared
    class ContentBasedDecorator
      def initialize(items_type)
        @items_type = items_type
        @content_filtering_service = set_content_filtering_service
      end

      def recommendations_data(user)
        @content_filtering_service.get_filtered_data(user, [@items_type])[@items_type]
      end

      private

      def set_content_filtering_service
        ContentBasedFiltering::Service.new
      end
    end
  end
end