module GameGenresHelper
  def show_game_genre_show_action?(current_user)
    current_user.admin?
  end

  def show_game_genre_edit_actions?(current_user)
    current_user.have_moderator_rights?
  end
end
