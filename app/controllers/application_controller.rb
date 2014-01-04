class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :get_signedin_user
  helper_method :signed_in?
  
  helper_method :is_admin?
  helper_method :can_edit?

  def signed_in?
    @user = User.find_by_username(session[:cas_user])
    not session[:cas_user].nil? and not @user.nil?
  end

  def is_admin?
    User.find_by_username(session[:cas_user]).is_admin
  end

  def authorize_admins_only
    if not is_admin? 
      redirect_to '/'
    end 
  end

  def get_signedin_user
    user = User.find_by_username(session[:cas_user])
  end

  def can_edit?
    user = User.find_by_username(session[:cas_user])
    if user.id == params[:id].to_i
      true
    elsif is_admin?
      true
    else
      false
    end
  end

end
