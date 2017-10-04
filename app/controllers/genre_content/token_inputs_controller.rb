module GenreContent
  class TokenInputsController < ApplicationController
    def index
      genre_type = params[:type]
      genre = concrete_genre(genre_type).find(params[:genre_id])
      render json: set_token_data(params[:term], genre, genre_type)
    end

    private

    def set_token_data(term, genre, genre_type)
      concrete_content_class(genre_type).token_inputs_for_genre(term, genre).to_json(only: [:id, :name])
    end

    #TODO: think
    def concrete_genre(genre_type)
      "#{genre_type.capitalize}Genre".constantize
    end

    def concrete_content_class(genre_type)
      genre_type.capitalize.constantize
    end
  end
end
