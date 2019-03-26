class ApplicationController < ActionController::Base
  before_action :login_required
  before_action :disabled_user_can_not_access

  add_flash_types :success, :danger # bootstrap用にflashを追加
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_path unless current_user
  end

  def disabled_user_can_not_access
    unless current_user&.is_enabled
      reset_session
      redirect_to login_path, danger: 'アカウントが無効です'
    end
  end
end
