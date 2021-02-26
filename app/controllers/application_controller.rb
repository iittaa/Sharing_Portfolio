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
      redirect_back(fallback_location: root_path)
      flash[:warning] = "管理者以外はアクセスできません"
    end
  end

  # ゲストユーザーかどうか確認する
  def check_guest
    if current_user.email == "guest@example.com"
      redirect_back(fallback_location: root_path)
      flash[:warning] = "ゲストユーザーは閲覧操作のみ可能です"
    end
  end

end
