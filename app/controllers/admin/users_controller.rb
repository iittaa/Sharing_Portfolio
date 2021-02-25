class Admin::UsersController < ApplicationController
before_action :admin_user

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      unless @user.password.nil?
        hash(@user)
      end
      flash[:success] = "ユーザー情報を編集しました"
      redirect_to user_url(@user)
    else
      render "edit"
    end
  end


  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:success] = "管理者側でアカウントを削除しました。"
    redirect_to root_url
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_image, :profile, :twitter_link, :github_link)
  end

end
