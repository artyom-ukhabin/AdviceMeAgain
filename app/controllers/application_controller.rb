class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  protected

  def params_with_user(params)
    params.merge! current_user_hash
  end

  def current_user_hash
    { user_id: current_user.id }
  end

  private

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = 'You are not authorized to access this resource!'
      redirect_to root_path
    end
  end
end
