class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back(fallback_location: root_path)
      flash[:success] = "コメントしました"
    else
      flash[:warning] = "コメントに失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
  end


  private


  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, :parent_id)
  end
end