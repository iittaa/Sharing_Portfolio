class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index update edit destroy]
  before_action :correct_user, only: %i[edit update destroy]
  before_action :admin_user, only: [:index]
  before_action :check_guest, only: %i[edit update destroy]

  def home
    @posts = Post.all.order(:created_at).limit(3) # タグ一覧を表示する際に使用する
    # @tag_list = Tag.all
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
    @stocks = Stock.where(user_id: @user.id).page(params[:page]).per(10)
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:success] = 'アカウントを削除しました。またのご利用をお待ちしております。'
    redirect_to root_url
  end

  def new_guest
    user = User.find_or_create_by(name: 'ゲストユーザー', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def following
    @user  = User.find_by(id: params[:id])
    @word = "フォロー"
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user  = User.find_by(id: params[:id])
    @word = "フォロワー"
    @users = @user.followers
    render 'show_follow'
  end

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     login(@user)
  #     hash(@user)
  #     flash[:success] = "アカウントを登録しました！これからよろしくね！"
  #     redirect_to user_url(@user)
  #   else
  #     render "new"
  #   end
  # end

  # def edit
  #   @user = User.find_by(id: params[:id])
  # end

  # def update
  #   @user = User.find(params[:id])
  #     if @user.update(user_params)
  #       hash(@user)
  #       flash[:success] = "ユーザー情報を編集しました!"
  #       redirect_to user_url(@user)
  #     else
  #       render "edit"
  #     end
  # end

  # def twitter_create
  #   auth = request.env['omniauth.auth']
  #   @user = User.find_by(
  #     provider: auth[:provider],
  #     uid: auth[:uid]
  #     )
  #   if @user
  #     login(@user)
  #     flash[:success] = "ログインしました"
  #     redirect_to user_url(@user)
  #   else
  #     @user = User.new(
  #       provider: auth[:provider],
  #       uid: auth[:uid],
  #       name: auth[:info][:name],
  #       remote_user_image_url: auth[:info][:image],
  #       profile: auth[:info][:description],
  #       twitter_link: auth[:info][:urls][:Twitter]
  #     )
  #     if @user.save
  #       login(@user)
  #       flash[:success] = "ログインしました"
  #       redirect_to user_url(@user)
  #     else
  #       flash[:warning] = "Twitterアカウントでログインができません。"
  #       render "new"
  #     end
  #   end
  # end

  private

  # 正しいユーザーかどうか確認する
  def correct_user
    @user = User.find_by(id: params[:id])
    unless @user && @user == current_user
      redirect_to root_url
      flash[:warning] = '自分のユーザー情報以外は変更することができません'
    end
  end

  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_image, :profile, :twitter_link, :github_link)
  # end
end
