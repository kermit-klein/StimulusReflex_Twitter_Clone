class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc).limit(10)
    @post = Post.new
  end

  def create
    Post.create(post_params)
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
