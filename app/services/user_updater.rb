class UserUpdater
  def initialize(user)
    @user = user
    @content_preferences_worker = ContentBasedFiltering::DestroyUserContentPreferencesWorker
    @personality_preferences_worker = ContentBasedFiltering::DestroyUserPersonalityPreferencesWorker
  end

  def destroy
    @content_preferences_worker.perform_async(@user.id)
    @personality_preferences_worker.perform_async(@user.id)
  end
end