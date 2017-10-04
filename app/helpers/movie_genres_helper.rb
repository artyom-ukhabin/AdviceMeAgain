module MovieGenresHelper
  def show_movie_genre_show_action?(current_user)
    current_user.admin?
  end

  def show_movie_genre_edit_actions?(current_user)
    current_user.have_moderator_rights?
  end
end
