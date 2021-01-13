module ApplicationHelper
  

  #セッション付与
  def login(user)
    session[:user_id] = user.id
  end

  #現在のユーザーを表す
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  #ログインする時にcookieを追加する。
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #cookieを削除する
  def logout!
    cookies.delete :user_id
    cookies.delete :remember_token
  end

end
