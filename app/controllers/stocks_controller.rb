class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @stock = current_user.stocks.create(post_id: @post.id)
  end

  def destroy
    @stock = Stock.find_by(
      post_id: @post.id,
      user_id: current_user.id
    )
    @stock.destroy
  end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
  end
end
