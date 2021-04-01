class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @user = User.find_by(id: params[:following_id])
    current_user.follow(@user)
    @user.create_notification_follow!(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    current_user.unfollow(@user)
  end
end
