class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :get_tag_all
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation name])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[email password password_confirmation name profile user_image
                                               twitter_link github_link user_image])
  end

  # 管理者かどうかの確認
  def admin_user
    unless current_user.admin?
      redirect_to root_url
      flash[:danger] = '管理者以外はアクセスできません'
    end
  end

  # ゲストユーザーかどうか確認する
  def check_guest
    if current_user.email == 'guest@example.com'
      redirect_to root_url
      flash[:danger] = 'ゲストユーザーは閲覧操作のみ可能です'
    end
  end

  def get_tag_all
    @tag_all = Post.tag_counts_on(:tags).order('count DESC')
  end

  protected

  def after_sign_up_path_for(_resource)
    # サインアップ後のリダイレクト先をrootに変更
    root_path
  end

  def after_update_path_for(_resource)
    user_path(current_user)
  end
end
