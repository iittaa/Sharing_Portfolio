class UsersController < ApplicationController
before_action :logged_in_user, only:[:show, :index, :update, :edit, :destroy ]
before_action :correct_user, only:[:edit, :update, :destroy]

  def home
    @posts = Post.all #タグ一覧を表示する際に使用する
    @tag_list = Tag.all
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
    @posts = @user.posts
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

  def twitter_create
    auth = request.env['omniauth.auth']
    @user = User.find_by(
      provider: auth[:provider],
      uid: auth[:uid]
      )
    if @user
      login(@user)
      flash[:success] = "ログインしました"
      redirect_to user_url(@user)
    else
      @user = User.new(
        provider: auth[:provider],
        uid: auth[:uid],
        name: auth[:info][:name],
        remote_user_image_url: auth[:info][:image]
      )
      if @user.save
        login(@user)
        flash[:success] = "ログインしました"
        redirect_to user_url(@user)
      else
        flash[:warning] = "Twitterアカウントでログインができません。"
        render "new"
      end
    end
  end


  private


  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_image)
  end

  #正しいユーザーかどうか確認する・
  def correct_user
    @user = User.find_by(id: params[:id])
    unless @user && @user == current_user
      redirect_to root_url
      flash[:warning] = "自分のユーザー情報以外は変更することができません"
    end
  end


end
