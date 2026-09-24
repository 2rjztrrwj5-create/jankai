class ApplicationsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    if @post.applications.exists?(user: Current.user)
      redirect_to @post, alert: "既に申請済みです。"
    else
      @application = @post.applications.new(user: Current.user, status: :pending)
      @application.save
      redirect_to @post, notice: "参加申請を送信しました。"
    end
  end
end