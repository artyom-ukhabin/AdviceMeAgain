class GameGenresController < ApplicationController
  before_filter :forbid_changes_for_strangers, except: [:index, :show]
  before_filter :ensure_user_is_admin, only: :show

  def index
    @game_genres = GameGenre.all
  end

  def show
    genre = GameGenre.find(params[:id])
    @genre_data = Shared::GenreDecorator.new.decorate(genre)
  end

  def new
    @game_genre = GameGenre.new
  end

  def edit
    @game_genre = GameGenre.find(params[:id])
  end

  def create
    @game_genre = GameGenre.new(game_genre_params)
    updater = GenreUpdater.new(@game_genre)
    if updater.save
      redirect_to @game_genre, notice: 'Game genre was successfully created.'
    else
      render :new
    end
  end

  def update
    @game_genre = GameGenre.find(params[:id])
    updater = GenreUpdater.new(@game_genre)
    if updater.update(game_genre_params)
      redirect_to @game_genre, notice: 'Game genre was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @game_genre = GameGenre.find(params[:id])
    updater = GenreUpdater.new(@game_genre)
    updater.destroy
    redirect_to game_genres_url, notice: 'Game genre was successfully destroyed.'
  end

  private

  def forbid_changes_for_strangers
    redirect_to game_genres_path unless current_user.have_moderator_rights?
  end

  def ensure_user_is_admin
    redirect_to band_genres_path unless current_user.admin?
  end

  def game_genre_params
    params.require(:game_genre).permit(:name)
  end
end
