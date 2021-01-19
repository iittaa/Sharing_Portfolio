class PostsController < ApplicationController

  def new
      @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    tag_list = params[:post][:tag_ids].split(",")
    if @post.save
      @post.save_tag(tag_list)
      flash[:success] = "ポートフォリオを公開しました！ありがとう！"
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(',')
  end

  def update
    @post = Post.find_by(id: params[:id])
    @tag_list = params[:post][:tag_ids].split(',')
    if @post.update(post_params)
      @post.save_tag(@tag_list)
      flash[:success] = "更新しました！"
      redirect_to post_url(@post)
    else
      render "edit"
    end
  end

  def index
    @posts = Post.all #タグ一覧を表示する際に使用する
    @tag_list = Tag.all
    @post = current_user.posts.build
  end

  def show
    @post = Post.find_by(id: params[:id])
    @stock = Stock.find_by(
      user_id: current_user.id,
      post_id: @post.id
    )
    @comment = Comment.new #投稿全体のコメント用の変数
    @comments = @post.comments
    @comment_reply = Comment.new
 
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to root_url
    flash[:success] = "ポートフォリオを削除してしまいました。。。。"
  end

  private

  def post_params
    params.require(:post).permit(:name, :content, :function, :language, :period, :point)
  end

end
