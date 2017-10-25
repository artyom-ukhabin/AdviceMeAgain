class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    updater = UserUpdater.new(current_user)
    updater.destroy
    super
  end
end
