module ApplicationHelper

  def signed_in?
    not session[:cas_user].nil?
  end
  
end
