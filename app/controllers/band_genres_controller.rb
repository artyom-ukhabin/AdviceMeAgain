class BandGenresController < ApplicationController
  before_filter :forbid_changes_for_strangers, except: [:index, :show]
  before_filter :ensure_user_is_admin, only: :show

  def index
    @band_genres = BandGenre.all
  end

  def show
    genre = BandGenre.find(params[:id])
    @genre_data = Shared::GenreDecorator.new.decorate(genre)
  end

  def new
    @band_genre = BandGenre.new
  end

  def edit
    @band_genre = BandGenre.find(params[:id])
  end

  def create
    @band_genre = BandGenre.new(band_genre_params)
    if @band_genre.save
      redirect_to @band_genre, notice: 'Band genre was successfully created.'
    else
      render :new
    end
  end

  def update
    @band_genre = BandGenre.find(params[:id])
    if @band_genre.update(band_genre_params)
      redirect_to @band_genre, notice: 'Band genre was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @band_genre = BandGenre.find(params[:id])
    @band_genre.destroy
    redirect_to band_genres_url, notice: 'Band genre was successfully destroyed.'
  end

  private

  def forbid_changes_for_strangers
    redirect_to band_genres_path unless current_user.have_moderator_rights?
  end

  def ensure_user_is_admin
    redirect_to band_genres_path unless current_user.admin?
  end

  def band_genre_params
    params.require(:band_genre).permit(:name)
  end
end
