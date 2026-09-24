class PostsController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_posts
  def new
    @post = Post.new
  end

  def create
    @post = Current.user.posts.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Current.user.posts.find(params[:id])
  end

  def update
    @post = Current.user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Current.user.posts.find(params[:id])
    @post.destroy
    redirect_to mypage_path
  end

  def approve
    application = Application.find_by(post_id: params[:id], user_id: params[:user_id])
    application.update(status: :approved)

    post = application.post
    approved_count = post.applications.approved.count

    if approved_count >= post.capacity && post.group.nil?
      group = post.create_group!(name: post.title)
      post.applications.approved.each do |app|
        group.group_members.create!(user: app.user)
      end
      group.group_members.create!(user: post.user)
    end

    redirect_to post_path(post), notice: "承認しました。"
  end

  def reject
    application = Application.find_by(post_id: params[:id], user_id: params[:user_id])
    application.update(status: :rejected)
    redirect_to post_path(application.post), notice: "却下しました。"
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :event_at, :capacity, :format, :prefecture)
  end

  def redirect_to_posts
    redirect_to posts_path, alert: "権限がありません。"
  end
end
