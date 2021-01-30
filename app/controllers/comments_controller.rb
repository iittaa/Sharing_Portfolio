class CommentsController < ApplicationController
  before_action :logged_in_user, only:[:create, :edit, :update, :destroy]
  before_action :correct_user, only:[:edit, :update, :destroy]


  def create
    @comment = current_user.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back(fallback_location: root_path)
      flash[:success] = "コメントしました！"
    else
      flash[:warning] = "1字〜500字以内でコメントを入力してください！"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post)
      flash[:success] = "コメントを編集しました"
    else
      flash[:warning] = "1字〜500字以内でコメントを入力してください！"
      redirect_back(fallback_location: root_path)
    end
  end



  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    flash[:success] = "コメントを削除しました！"
    redirect_back(fallback_location: root_path)
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, :parent_id)
  end

  #正しいユーザーかどうか確認する
  def correct_user
    @comment = Comment.find_by(id: params[:id])
      unless @comment.user_id == current_user.id
        redirect_to root_url
        flash[:warning] = "自分のコメント以外は変更することができません"
      end
    end
end
