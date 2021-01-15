class PostsController < ApplicationController

  def new
    if !current_user.nil?
      @post = current_user.posts.build
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "ポートフォリオを公開しました！"
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
    @stock = Stock.find_by(
      user_id: current_user.id,
      post_id: @post.id
    )

  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:name, :content, :function, :language, :period, :point)
  end

end
