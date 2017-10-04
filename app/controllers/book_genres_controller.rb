class BookGenresController < ApplicationController
  before_filter :forbid_changes_for_strangers, except: [:index, :show]
  before_filter :ensure_user_is_admin, only: :show

  def index
    @book_genres = BookGenre.all
  end

  def show
    genre = BookGenre.find(params[:id])
    @genre_data = Shared::GenreDecorator.new.decorate(genre)
  end

  def new
    @book_genre = BookGenre.new
  end

  def edit
    @book_genre = BookGenre.find(params[:id])
  end

  def create
    @book_genre = BookGenre.new(book_genre_params)
    if @book_genre.save
      redirect_to @book_genre, notice: 'Book genre was successfully created.'
    else
      render :new
    end
  end

  def update
    @book_genre = BookGenre.find(params[:id])
    if @book_genre.update(book_genre_params)
      redirect_to @book_genre, notice: 'Book genre was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book_genre = BookGenre.find(params[:id])
    @book_genre.destroy
    redirect_to book_genres_url, notice: 'Book genre was successfully destroyed.'
  end

  private

  def forbid_changes_for_strangers
    redirect_to book_genres_path unless current_user.have_moderator_rights?
  end

  def ensure_user_is_admin
    redirect_to band_genres_path unless current_user.admin?
  end

  def book_genre_params
    params.require(:book_genre).permit(:name)
  end
end