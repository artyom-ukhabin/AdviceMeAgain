module Layouts
  module WithRecommendationsSection
    CONTENT_FOLDER_NAME = 'content'
    PERSONALITY_FOLDER_NAME = 'personality'

    #TODO: This code should be reused some way
    def recommendations_section_folder(items_type)
      items_type = format_items_type(items_type)
      return CONTENT_FOLDER_NAME if Content.content_type? items_type
      return PERSONALITY_FOLDER_NAME if items_type == Personality::TYPE
      nil
    end

    private

    def format_items_type(items_type)
      items_type.downcase.singularize
    end
  end
end