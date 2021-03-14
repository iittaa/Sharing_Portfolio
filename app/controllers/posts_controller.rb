class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update index show destroy]
  before_action :correct_user, only: %i[edit update destroy]
  before_action :check_guest, only: %i[new create edit update destroy]

  def new
    @post = current_user.posts.build
    @tags = @post.tag_counts_on(:tags)
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'ポートフォリオを公開しました！ありがとう！'
      redirect_to posts_url
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:success] = '更新しました！'
      redirect_to post_url(@post)
    else
      render 'edit'
    end
  end

  def index
    @posts = Post.all.page(params[:page]).per(9)
    @tags = Post.tag_counts_on(:tags).order('count DESC') # タグ一覧を表示
    @tag_posts = Post.tagged_with(params[:tag]).page(params[:page]).per(9) if @tag = params[:tag]
  end

  def show
    @post = Post.find_by(id: params[:id])
    @stock = Stock.find_by(
      user_id: current_user.id,
      post_id: @post.id
    )
    @comment = Comment.new # 投稿全体のコメント用の変数
    @comments = @post.comments
    @tags = @post.tag_counts_on(:tags) # 投稿に紐づくタグを表示
    # 投稿をランダムに5つ取得
    @posts = Post.all
    @random = @posts.sample(5)
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to root_url
    flash[:success] = 'ポートフォリオを削除してしまいました。。。。'
  end

  private

  def post_params
    params.require(:post).permit(:name, :content, :image, :url, :period, :point, :tag_list)
  end

  # 正しいユーザーかどうか確認する
  def correct_user
    @post = Post.find_by(id: params[:id])
    unless @post.user_id == current_user.id
      redirect_to root_url
      flash[:warning] = '自分の投稿したポートフォリオ以外の情報は変更することができません'
    end
  end
end
