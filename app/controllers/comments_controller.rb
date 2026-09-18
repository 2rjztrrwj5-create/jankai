class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = Current.user
    if @comment.save
      redirect_to @post
    else
      redirect_to @post, alert: "コメントの投稿に失敗しました。"
    end
  end

  def destroy
    @comment = Current.user.comments.find(params[:id])
    @post = @comment.post
    @comment.destroy
    redirect_to @post
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
