class SearchesController < ApplicationController
  def index
    @keyword = params[:keyword]
    if @keyword.present?
      @posts = Post.where("title LIKE :keyword OR body LIKE :keyword", keyword: "%#{@keyword}%")
      @users = User.where("name LIKE :keyword", keyword: "%#{@keyword}%")
    else
      @posts = []
      @users = []
    end
  end
end
