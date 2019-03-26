class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: [:edit, :activate]

  def index
    @users = User.where(admin: false).all
  end

  def edit
  end

  def activate
    if @user.is_enabled?
      @user.update_attribute(:is_enabled, false)
    else
      @user.update_attribute(:is_enabled, true)
    end
    redirect_to edit_admin_user_path(@user), success: "#{User.model_name.human}のアカウント状態を変更しました"
  end 

  private

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end
end
