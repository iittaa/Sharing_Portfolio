class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[edit update destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @post = @comment.post
    if @comment.save
      render :index
      @post.create_notification_comment!(current_user, @comment.id)
    else
      flash[:danger] = '1字〜500字以内でコメントを入力してください！'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    render :index
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end

  # 正しいユーザーかどうか確認する
  def correct_user
    @comment = Comment.find_by(id: params[:id])
    unless @comment.user_id == current_user.id || current_user.admin?
      redirect_to root_url
      flash[:danger] = '自分のコメント以外は変更することができません'
    end
  end
end
