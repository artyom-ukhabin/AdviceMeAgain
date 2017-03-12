module UsersHelper
  def actual_profile_path(user)
    user.profile ? profile_path(user.profile) : new_profile_path
  end
end