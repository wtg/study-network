class PagesController < ApplicationController

  def home
    @user = User.find_by_username(session[:cas_user])
    @posts = Post.recent_posts[0..4]
  end

end
