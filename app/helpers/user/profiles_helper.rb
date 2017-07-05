module User::ProfilesHelper
  def can_edit_profile?(user, profile)
    user == profile.user || user.admin?
  end
end
