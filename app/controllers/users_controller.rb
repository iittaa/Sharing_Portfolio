class UsersController < ApplicationController
before_action :logged_in_user, only:[:show, :index, :update, :edit, :destroy ]
before_action :correct_user, only:[:edit, :update, :destroy]

  def home
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      flash[:success] = "アカウントを登録しました！これからよろしくね！"
      redirect_to user_url(@user)
    else
      render "new"
    end
  end

  def index
  end

  def show
    @user = User.find(params[:id])
    @feed_items = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を編集しました"
      redirect_to user_url(@user)
    else
      render "edit"
    end
  end
  
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:success] = "アカウントを削除しました。"
    redirect_to root_url
  end


  private


  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user && @user == current_user
      redirect_to root_url
      flash[:warning] = "自分のユーザー情報以外は変更することができません"
    end
  end

  def logged_in_user
    if current_user.nil?
      redirect_to root_url
      flash[:warning] = "ログインしてください"
    end
  end


end
