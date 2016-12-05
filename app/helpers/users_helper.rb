module UsersHelper
  def actual_profile_path(user)
    user.profile ? user_profile_path(user) : new_user_profile_path(user)
  end
end