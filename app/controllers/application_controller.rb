class ApplicationController < ActionController::Base
  include ApplicationHelper

  #ログインユーザーの確認
  def logged_in_user
    if current_user.nil?
      flash[:warning] = "ログインしてください"
      redirect_to home_users_url
    end
  end

  #管理者かどうかの確認
  def admin_user
    unless current_user.admin?
      redirect_to root_url
      flash[:warning] = "管理者以外はアクセスできません"
    end
  end

end
