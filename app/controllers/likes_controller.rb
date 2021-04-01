class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = current_user.likes.create(post_id: @post.id)
    post = Post.find_by(id: params[:post_id])
    # いいねの通知
    post.create_notification_like!(current_user)
  end

  def destroy
    @like = Like.find_by(
      post_id: @post.id,
      user_id: current_user.id
    )
    @like.destroy
  end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
  end
end
