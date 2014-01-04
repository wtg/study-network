module PagesHelper

  # Activity Feed Methods
  def recent_posts
    user_id = get_signedin_user.id
    posts = Post.where(user_id: user_id).sort_by(&:created_at).reverse
    posts[0..4]
  end

end
