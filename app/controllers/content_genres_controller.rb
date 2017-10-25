class ContentGenresController < ApplicationController
  def edit
    content = Content.find(params[:content_id])
    @genres_data = ContentGenresDecorator.new.genres_data(content)
    render 'content/genres_section/show_form'
  end

  def create
    content = Content.find(params[:content_id])
    updater = ContentGenresUpdater.new(content)
    updater.genre_ids = params[:genres_ids]
    @genres_data = ContentGenresDecorator.new.genres_data(content)
    render 'content/genres_section/update_section'
  end
end
