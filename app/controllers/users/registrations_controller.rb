# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  protected

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_update_path_for(resource)
    # 自分で設定した「マイページ」へのパス
    user_path(resource)
  end
end
