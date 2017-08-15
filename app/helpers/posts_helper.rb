module PostsHelper
  def actual_like_path(post, already_liked)
    if already_liked
      link_to 'Unlike', post_likes_destroy_path(post), remote: true, class: :user_like_activated
    else
      link_to 'Like', post_likes_create_path(post), remote: true, class: :user_like_deactivated
    end
  end
end