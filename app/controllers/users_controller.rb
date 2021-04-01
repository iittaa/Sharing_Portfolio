class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index update edit destroy]
  before_action :correct_user, only: %i[destroy]
  before_action :admin_user, only: %i[index edit update]
  before_action :check_guest, only: %i[destroy]

  def home
    # タグ一覧を表示する際に使用する
    @posts = Post.all.order(:created_at).limit(3) 
  end

  # 管理者用
  def index
    @users = User.all.page(params[:page]).per(15)
  end

  # 管理者用
  def edit
    @user = User.find_by(id: params[:id])
  end

  # 管理者用
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を編集しました!'
      redirect_to user_url(@user)
    else
      render 'edit'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
    @stocks = Stock.where(user_id: @user.id).page(params[:page]).per(10)
    @likes = Like.where(user_id: @user.id).page(params[:page]).per(10)

    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          if cu.room_id == u.room_id
            @is_room = true
            @room_id = cu.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:success] = 'アカウントを削除しました。またのご利用をお待ちしております。'
    redirect_to root_url
  end

  def new_guest
    user = User.find_or_create_by(name: 'ゲストユーザー', email: 'guest@example.com') do |guest|
      guest.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def following
    @user = User.find_by(id: params[:id])
    @word = 'フォロー'
    @users = @user.following.page(params[:page]).per(15)
    render 'show_follow'
  end

  def followers
    @user = User.find_by(id: params[:id])
    @word = 'フォロワー'
    @users = @user.followers.page(params[:page]).per(15)
    render 'show_follow'
  end

  private

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find_by(id: params[:id])
    unless @user && @user == current_user || current_user.admin?
      redirect_to root_url
      flash[:warning] = '自分のユーザー情報以外は変更することができません'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :user_image, :profile, :twitter_link, :github_link, :remove_user_image)
  end
end
