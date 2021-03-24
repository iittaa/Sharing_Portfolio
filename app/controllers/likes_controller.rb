class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[create index destroy]
  before_action :set_post

  def create
    @like = current_user.likes.create(post_id: @post.id)
    post = Post.find_by(id: params[:post_id])
    post.create_notification_like!(current_user)
  end

  def destroy
    @like = Like.find_by(
      post_id: @post.id,
      user_id: current_user.id
    )
    @like.destroy
  end

  # def index
  #   @likes = Like.where(user_id: current_user.id).page(params[:page]).per(10)
  # end

  # def show
  #   @like = Like.find_by(post_id: params[:id]).page(params[:page]).per(100)
  # end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
  end
end
