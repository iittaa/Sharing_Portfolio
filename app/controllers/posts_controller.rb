class PostsController < ApplicationController

  def new
      @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    @tag_list = params[:post][:tag_name].split(",")
    if @post.save
      @post.save_tag(@tag_list)
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
  end

  def search
    @tag_list = Tag.all  
    @tag = Tag.find(params[:tag_id])  
    @posts = @tag.posts.all 
  end


  private

  def post_params
    params.require(:post).permit(:name, :content, :function, :language, :period, :point)
  end

end
