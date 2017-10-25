class GenreContentController < ApplicationController
  def edit
    genre_type = params[:type]
    genre = concrete_genre(genre_type).find(params[:genre_id])
    @content_data = GenreContentDecorator.new.content_data(genre)
    render "#{genre_type}_genres/content_section/show_form"
  end

  def create
    genre_type = params[:type]
    genre = concrete_genre(genre_type).find(params[:genre_id])
    updater = GenreContentUpdater.new(genre)
    updater.content_ids = params[:content_ids]
    @content_data = GenreContentDecorator.new.content_data(genre)
    render "#{genre_type}_genres/content_section/update_section"
  end

  private

  #TODO: think
  def concrete_genre(genre_type)
    "#{genre_type.capitalize}Genre".constantize
  end
end
