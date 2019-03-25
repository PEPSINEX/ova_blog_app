class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to admin_users_path
      else
        redirect_to user_path(user), success: 'ログインしました'
      end
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
