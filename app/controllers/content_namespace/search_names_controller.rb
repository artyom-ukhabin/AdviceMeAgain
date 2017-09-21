module ContentNamespace
  class SearchNamesController < ApplicationController
    include ContentTypesMethods

    def index
      type = check_type(params[:type])
      render json: {error: 'Wrong content type'} and return unless type
      render json: set_search_data(type, params[:term])
    end

    private

    def set_search_data(type, term)
      current_model(type).autocomplete_data(term)
    end
  end
end
