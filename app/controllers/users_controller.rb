class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :can_not_access_another_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def edit
  end


  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, success: "#{User.model_name.human}登録をしました"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, success: "#{User.model_name.human}を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to new_user_path, danger: "#{User.model_name.human}を削除しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def can_not_access_another_user
    redirect_to root_path unless @user == current_user
  end
end
