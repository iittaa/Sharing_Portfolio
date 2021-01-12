class UsersController < ApplicationController

  def home
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "アカウントを登録しました！"
      redirect_to user_url(@user)
    else
      render "new"
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def delete
  end


  private


  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end



end
