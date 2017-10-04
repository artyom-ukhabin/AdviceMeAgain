module BookGenresHelper
  def show_book_genre_show_action?(current_user)
    current_user.admin?
  end

  def show_book_genre_edit_actions?(current_user)
    current_user.have_moderator_rights?
  end
end
