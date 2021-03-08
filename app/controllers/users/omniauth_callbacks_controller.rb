# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    callback_from :twitter
  end

  private

  # コールバック時に行う処理
  def callback_from(provider)
    provider = provider.to_s

    @user = User.find_for_oauth(request.env['omniauth.auth'])

    # persisted?でDBに保存済みかどうか判断
    if @user.persisted?
      # サインアップ時に行いたい処理があればここに書きます。
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
