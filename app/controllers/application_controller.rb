class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :name, :profile, :user_image, :twitter_link, :github_link])
  end

  #ログインユーザーの確認
  def logged_in_user
    unless user_signed_in?
      flash[:danger] = "ログインしてください"
      redirect_to home_users_url
    end
  end

  #管理者かどうかの確認
  def admin_user
    unless current_user.admin?
      redirect_back(fallback_location: root_path)
      flash[:danger] = "管理者以外はアクセスできません"
    end
  end

  # ゲストユーザーかどうか確認する
  def check_guest
    if current_user.email == "guest@example.com"
      redirect_back(fallback_location: root_path)
      flash[:danger] = "ゲストユーザーは閲覧操作のみ可能です"
    end
  end

  protected

  def after_sign_up_path_for(resource)
    # サインアップ後のリダイレクト先をrootに変更
    root_path
  end

  def after_update_path_for(resource)
    user_path(current_user)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end


end
