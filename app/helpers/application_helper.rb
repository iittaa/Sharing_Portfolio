module ApplicationHelper
  

  #セッション付与
  def login(user)
    session[:user_id] = user.id
  end

  def hash(user)
    user.password_hash
  end

  #現在のユーザーを表す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        login(user)
        user = @current_user
      end
    end
  end

  #ログインする時にcookieを追加する。
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #クッキーを削除するのと、カラムの値を"nil"にする
  def forget(user)
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end


  #現在のユーザーである場合にtrueを返す
  def current_user?(user)
    user && user == current_user
  end

end
