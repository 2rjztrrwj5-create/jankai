class CommentsController < ApplicationController
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.new(comment_params)
    @comment.user = Current.user
    if @comment.save
      redirect_to @commentable
    else
      redirect_to @commentable, alert: "コメントの投稿に失敗しました。"
    end
  end

  def destroy
    @comment = Current.user.comments.find(params[:id])
    @commentable = @comment.commentable
    @comment.destroy
    redirect_to @commentable
  end

  private

  def find_commentable
    if params[:post_id]
      Post.find(params[:post_id])
    else
      Group.find(params[:group_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end