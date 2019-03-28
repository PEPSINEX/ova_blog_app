class SessionsController < ApplicationController
  skip_before_action :login_required
  skip_before_action :disabled_user_can_not_access

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password]) && user.admin?
      session[:user_id] = user.id
      redirect_to admin_users_path, success: '管理者としてログインしました'
    elsif user&.authenticate(session_params[:password]) && !user.is_enabled?
      redirect_to login_path, danger: 'アカウントが無効です'
    elsif user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), success: 'ログインしました'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path, danger: 'ログアウトしました'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
