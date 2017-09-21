module ContentNamespace
  class TokenInputsController < ApplicationController
    include ContentTypesMethods

    def index
      current_types = set_types(params[:type])
      personality = Personality.find(params[:personality_id])
      render json: set_token_data(current_types, personality, params[:term])
    end

    private

    #TODO: move to decorator if it will be more complicated

    def set_token_data(current_types, personality, term)
      current_types.inject({}) do |token_data, content_type|
        humanized_content_type = humanize_content_type(content_type)
        token_data[humanized_content_type] = set_single_type_data(content_type, personality, term)
        token_data
      end.to_json
    end

    def set_single_type_data(type, personality, term)
      current_model(type).token_inputs_for_personality(personality, term).as_json(only: [:id, :name])
    end

    def humanize_content_type(content_type)
      content_type.capitalize.pluralize
    end
  end
end
