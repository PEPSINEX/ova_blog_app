class ApplicationController < ActionController::Base
  add_flash_types :success, :danger # bootstrap用にflashを追加
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
