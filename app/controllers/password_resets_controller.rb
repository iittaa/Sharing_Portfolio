class PasswordResetsController < ApplicationController
  before_action :check_expiration, only: %i[edit update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      UserMailer.password_reset(@user).deliver_now
      flash[:info] = 'メールを送信しました'
      redirect_to root_url
    else
      flash[:warning] = 'メールアドレスが見つかりません'
      render 'new'
    end
  end

  def edit
    @user = User.find_by(email: params[:email])
  end

  def update
    @user = User.find_by(email: params[:email])
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update(user_params)
      login(@user)
      redirect_to user_url(@user)
      flash[:success] = 'パスワードを変更しました'
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # メールの有効期限を確認する
  def check_expiration
    @user = User.find_by(email: params[:email])
    if @user.reset_sent_at < 2.hours.ago
      flash[:warning] = 'URLの有効期限が切れています。'
      redirect_to new_password_reset_url
    end
  end
end
