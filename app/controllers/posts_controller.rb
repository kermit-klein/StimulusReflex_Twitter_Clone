class PostsController < ApplicationController
  include CableReady::Broadcaster
  def index
    @posts = Post.order(created_at: :desc).limit(10)
    @post = Post.new
  end

  def create
    post = Post.create(post_params)
    cable_ready['feed'].insert_adjacent_html(
      selector: '#feed',
      position: 'afterbegin',
      html: render_to_string(partial: 'posts/post',
                             locals: { post: post })
    )
    cable_ready.broadcast
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
