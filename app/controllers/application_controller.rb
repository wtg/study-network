class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def signed_in?
    not session[:cas_user].nil?
  end

  def is_admin?
    User.find_by_username(session[:cas_user]).is_admin
  end

  def authorize_admins_only
    if not is_admin? 
      redirect_to '/'
    end 
  end

end
