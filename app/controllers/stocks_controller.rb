class StocksController < ApplicationController
  before_action :logged_in_user, only:[:create, :index, :destroy]
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

  def index
    @stocks = Stock.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  def show
    @stock = Stock.find_by(post_id: params[:id]).page(params[:page]).per(100)
  end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
  end



end
