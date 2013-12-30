module ApplicationHelper

  def signed_in?
    @user = User.find_by_username(session[:cas_user])
    not session[:cas_user].nil? and not @user.nil?
  end

  def get_signedin_name
    @user = User.find_by_username(session[:cas_user])
    if @user.real_name
      @user.real_name
    else
      @user.username 
    end
  end

  def get_signedin_id
    @user = User.find_by_username(session[:cas_user])
    @user.id
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

  def is_admin?
    User.find_by_username(session[:cas_user]).is_admin
  end
  
end
