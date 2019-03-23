class ApplicationController < ActionController::Base
  before_action :login_required

  add_flash_types :success, :danger # bootstrap用にflashを追加
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_path unless current_user
  end
end
