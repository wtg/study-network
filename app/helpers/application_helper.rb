module ApplicationHelper

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

  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=200"
  end
  
end
