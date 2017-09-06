#https://www.toptal.com/algorithms/predicting-likes-inside-a-simple-recommendation-engine
module Collaborations
  class Service
    AVAILABLE_TYPES = Content::TYPES + ['personality']

    def initialize(items_types = nil)
      items_types = filter_items_types(items_types)
      @handlers_array = fill_handlers_array(items_types)
    end

    def get_collaboration_data(user)
      @handlers_array.inject({}) do |collaboration_data, handler|
        collaboration_data[handler.items_type] = handler.get_collaboration_data(user)
      end
    end

    def update_collaboration_data(user)
      @handlers_array.each do |handler|
        handler.update_collaboration_data(user)
      end
    end

    private

    def filter_items_types(raw_items_types)
      return AVAILABLE_TYPES if raw_items_types == nil
      notice_about_incorrect_types(raw_items_types)
      raw_items_types & AVAILABLE_TYPES
    end

    def notice_about_incorrect_types(raw_items_types)
      incorrect_types = raw_items_types - AVAILABLE_TYPES
      incorrect_types.each do |incorrect_type|
        Rails.logger.info("#{incorrect_type} is not valid items type for generate collaboration")
      end
    end

    def fill_handlers_array(items_types)
      items_types.inject([]) do |handlers_array, items_type|
        handlers_array << Collaborations::SingleTypeHandler.new(items_type)
      end
    end
  end
end