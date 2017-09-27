module RecommendationsDecorators
  module Shared
    class CollaborationsDecorator
      def initialize(collaboration_type)
        @collaboration_type = collaboration_type
        @collaborations_service = set_collaborations_service(@collaboration_type)
      end

      def recommendations_data(user)
        @collaborations_service.get_collaboration_data(user)[@collaboration_type]
      end

      private

      def set_collaborations_service(type)
        Collaborations::Service.new([type])
      end
    end
  end
end