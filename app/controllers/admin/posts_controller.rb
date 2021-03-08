class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(10) # タグ一覧を表示する際に使用する
    @tag_list = Tag.all
    @post = current_user.posts.build
  end

  def show
    @post = Post.find_by(id: params[:id])
    @stock = Stock.find_by(
      user_id: current_user.id,
      post_id: @post.id
    )
    @comment = Comment.new # 投稿全体のコメント用の変数
    @comments = @post.comments
    @comment_reply = Comment.new
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @tag_list = @post.tags.pluck(:tag_name).split(/[[:blank:]]+/)
  end

  def update
    @post = Post.find_by(id: params[:id])
    @tag_list = params[:post][:tag_ids].downcase.split(/[[:blank:]]+/)
    if @post.update(post_params)
      @post.save_tag(@tag_list)
      flash[:success] = '管理者側でポートフォリオを更新しました。'
      redirect_to admin_post_url(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to root_url
    flash[:success] = '管理者側でポートフォリオを削除しました'
  end

  private

  def post_params
    params.require(:post).permit(:name, :content, :image, :url, :period, :point)
  end
end
