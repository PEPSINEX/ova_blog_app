class UsersController < ApplicationController
  before_action :set_blog, only: [:show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.where(admin: false).find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def can_not_access_another_user
    redirect_to root_path unless @user == current_user || current_user.admin?
  end
end
