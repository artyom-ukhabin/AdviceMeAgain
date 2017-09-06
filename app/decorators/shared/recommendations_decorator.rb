module Shared
  class RecommendationsDecorator
    def recommendations_data(current_types, user)
      current_types.inject([]) do |recommendations_data, type|
        recommendations_data << build_single_type_hash(type, user)
      end
    end

    private

    def build_single_type_hash(type, user)
      single_type_hash = {}
      single_type_hash[:type] = type.capitalize.pluralize
      single_type_hash[:collaborations_data] = get_collaboration_data(type, user)
      single_type_hash
    end

    def get_collaboration_data(type, user)
      @collaboration_service = Collaborations::Service.new([type])
      @collaboration_service.get_collaboration_data(user)
    end
  end
end