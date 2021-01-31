class PostsController < ApplicationController
  before_action :logged_in_user, only:[:new, :create, :edit, :update, :index, :show, :destroy]
  before_action :correct_user, only:[:edit, :update, :destroy]

  def new
      @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    @tag_list = params[:post][:tag_ids].downcase.split(/[[:blank:]]+/)
    if @post.save
      @post.save_tag(@tag_list)
      flash[:success] = "ポートフォリオを公開しました！ありがとう！"
      redirect_to posts_url
    else
      render "new"
    end
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
      flash[:success] = "更新しました！"
      redirect_to post_url(@post)
    else
      render "edit"
    end
  end

  def index
    @posts = Post.all.page(params[:page]).per(10) #タグ一覧を表示する際に使用する
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
    params.require(:post).permit(:name, :content, :image, :url, :period, :point)
  end

  #正しいユーザーかどうか確認する
  def correct_user
  @post = Post.find_by(id: params[:id])
    unless @post.user_id == current_user.id
      redirect_to root_url
      flash[:warning] = "自分の投稿したポートフォリオ以外の情報は変更することができません"
    end
  end


end
