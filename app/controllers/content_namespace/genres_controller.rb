class ContentNamespace::GenresController < ApplicationController
  layout "with_recommendations_section"

  def index
    content_type = Content.check_type(params[:type]) #TODO: rewrite
    filtered_content = content_class(content_type).with_genre_name(params[:genre_name])
    @content_data = set_index_data(content_type, filtered_content)
    @layout_data = RandomRecommendation::Fetcher.new([params[:type]]).get_recommendation(current_user)
  end

  private

  def content_class(content_type)
    content_type.capitalize.constantize
  end

  def set_index_data(content_type, filtered_content)
    index_data = {}
    index_data[:type] = content_type
    index_data[:content_collection] = decorate_filtered_content(filtered_content)
    index_data
  end

  def decorate_filtered_content(filtered_content)
    filtered_content.inject([]) do |index_data, content|
      index_data << ContentDecorators.data_for_index_action(content, current_user)
    end
  end
end
