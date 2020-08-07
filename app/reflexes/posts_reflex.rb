# frozen_string_literal: true

class PostsReflex < ApplicationReflex
  include CableReady::Broadcaster
  include ActionView::RecordIdentifier
  def repost
    post = Post.find(element.dataset[:id])
    post.increment! :reposts_count
    cable_ready['feed'].text_content(
      selector: "##{dom_id(post, 'reposts')}",
      text: post.reposts_count
    )
    cable_ready.broadcast
  end

  def like
    post = Post.find(element.dataset[:id])
    post.increment! :likes_count
    cable_ready['feed'].text_content(
      selector: "##{dom_id(post, 'likes')}",
      text: post.likes_count
    )
    cable_ready.broadcast
  end
end
