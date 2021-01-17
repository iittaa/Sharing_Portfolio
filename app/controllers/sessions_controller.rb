class SessionsController < ApplicationController

  def new
  end

  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.find_or_create_from_auth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to root_url
      flash[:success] = "Twitterアカウントでログインしました！"
    else
      @user = User.find_by(email: params[:session][:email])
      if @user && @user.authenticate(params[:session][:password])
      login(@user)
        if params[:session][:remember_me] == "1"
          remember(@user)
        else
          forget(@user)
        end
        flash[:success] = "ログインしました！"
        redirect_to user_url(@user)
      else
        flash[:warning] = "メールアドレスとパスワードの組み合わせが正しくありません。"
        render "new"
      end
    end
  end

  def destroy
    if !current_user.nil?
      session[:user_id] = nil
      forget(@current_user)
    end
    flash[:success] = "ログアウトしました！"
    redirect_to root_url
  end
  




end
