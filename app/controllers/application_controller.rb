class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :get_signedin_user
  helper_method :signed_in?
  
  helper_method :can_edit?

  def signed_in?
    @user = User.find_by_username(session[:cas_user])
    not session[:cas_user].nil? and not @user.nil?
  end

  def can_edit?
    user = User.find_by_username(session[:cas_user])
    if user 
      if user.id == params[:id].to_i
        return true
      end
    end
    false
  end

  def get_signedin_user
    user = User.find_by_username(session[:cas_user])
  end

  def user_edit_privileges
    user = User.find_by_username(session[:cas_user])
    if user != nil
      if user.id != params[:id].to_i
        redirect_to "/"
      end
    end
  end

  def registrations_privileges
    user = User.find_by_username(session[:cas_user])
    if user != nil
      if user.id != params[:user_id].to_i
        redirect_to "/"
      end
    end
  end

  def post_edit_privileges
    user = User.find_by_username(session[:cas_user])
    post = Post.find(params[:id])
    if user != nil and post != nil
      if post.user_id != user.id
        redirect_to "/"
      end
    end
  end

  def reply_edit_privileges
    user = User.find_by_username(session[:cas_user])
    post = Post.find(params[:post_id])
    if user != nil and post != nil
      if post.user_id != user.id
        redirect_to "/"
      end
    end
  end

  def basic_controller_privileges
    if session[:cas_user] == nil
      redirect_to "/"
    end
  end

end