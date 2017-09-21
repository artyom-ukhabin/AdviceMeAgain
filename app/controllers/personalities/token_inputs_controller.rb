module Personalities
  class TokenInputsController < ApplicationController
    def index
      content = Content.find(params[:content_id])
      render json: set_token_data(params[:term], content)
    end

    private

    def set_token_data(term, content)
      Personality.token_inputs_for_content(term, content).to_json(only: [:id, :name])
    end
  end
end
