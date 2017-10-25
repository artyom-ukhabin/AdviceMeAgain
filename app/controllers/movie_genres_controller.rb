class MovieGenresController < ApplicationController
  before_filter :forbid_changes_for_strangers, except: [:index, :show]
  before_filter :ensure_user_is_admin, only: :show

  def index
    @movie_genres = MovieGenre.all
  end

  def show
    genre = MovieGenre.find(params[:id])
    @genre_data = Shared::GenreDecorator.new.decorate(genre)
  end

  def new
    @movie_genre = MovieGenre.new
  end

  def edit
    @movie_genre = MovieGenre.find(params[:id])
  end

  def create
    @movie_genre = MovieGenre.new(movie_genre_params)
    updater = GenreUpdater.new(@movie_genre)
    if updater.save
      redirect_to @movie_genre, notice: 'Movie genre was successfully created.'
    else
      render :new
    end
  end

  def update
    @movie_genre = MovieGenre.find(params[:id])
    updater = GenreUpdater.new(@movie_genre)
    if updater.update(movie_genre_params)
      redirect_to @movie_genre, notice: 'Movie genre was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @movie_genre = MovieGenre.find(params[:id])
    updater = GenreUpdater.new(@movie_genre)
    updater.destroy
    redirect_to movie_genres_url, notice: 'Movie genre was successfully destroyed.'
  end

  private

  def forbid_changes_for_strangers
    redirect_to movie_genres_path unless current_user.have_moderator_rights?
  end

  def ensure_user_is_admin
    redirect_to band_genres_path unless current_user.admin?
  end

  def movie_genre_params
    params.require(:movie_genre).permit(:name)
  end
end
