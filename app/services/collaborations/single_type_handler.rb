module Collaborations
  class SingleTypeHandler
    attr_reader :items_type

    def initialize(items_type)
      @items_type = items_type
      @queries_aggregator = set_collaboration_queiries_aggregator(@items_type)
      @rater = Collaborations::Rater.new(@items_type, @queries_aggregator)
      @similars = Collaborations::Similars.new(@items_type, @rater)
      @recommendations = Collaborations::Recommendations.new(@items_type, @rater, @similars)
    end

    def get_collaboration_data(user)
      predictions_data = @recommendations.for_user(user)
      recommended_items = get_recommended_items(predictions_data)
      predictions_data.inject([]) do |collaboration_data, prediction_object|
        collaboration_data << build_collaboration_hash(recommended_items, prediction_object)
      end
    end

    #TODO: for single user cause of not producing infinite spinners

    def update_collaboration_data(user)
      @similars.update user
      @recommendations.update user
    end

    private

    def type_class_name(type)
      type.classify
    end

    def get_recommended_items(predictions_data)
      items_ids = get_recommended_items_ids(predictions_data)
      type_class_name(@items_type).constantize.find(items_ids)
    end

    def get_recommended_items_ids(predictions_data)
      predictions_data.map do |prediction_object|
        prediction_object.item_id
      end
    end

    def build_collaboration_hash(recommended_items, prediction_object)
      collaboration_hash = {}
      collaboration_hash[:item] = recommended_items.detect{ |item| item.id == prediction_object.item_id}
      collaboration_hash[:prediction] = prediction_object.prediction_value * 100
      collaboration_hash
    end

    def set_collaboration_queiries_aggregator(items_type)
      #TODO: not the controller responsibility, looks like the right place
      #TODO: but this problem caused by union of two rate types
      #TODO: need to do something with this shit on analysis phase
      aggregator_type = (Content::TYPES.include? items_type) ? 'Content' : type_class_name(items_type)
      "Collaborations::#{aggregator_type}QueriesAggregator".constantize.new(items_type)
    end
  end
end