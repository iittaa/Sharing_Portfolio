class ApplicationController < ActionController::Base
  include ApplicationHelper

  #ログインユーザーの確認
  def logged_in_user
    if current_user.nil?
      flash[:warning] = "ログインしてください"
      redirect_to home_users_url
    end
  end




end
