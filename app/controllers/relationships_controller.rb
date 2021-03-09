class RelationshipsController < ApplicationController

  def create
    @user = User.find_by(id: params[:following_id])
    current_user.follow(@user)
  end

  def destroy
    @user = User.find_by(id: params[:id])
    current_user.unfollow(@user)
  end

end
