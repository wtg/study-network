class SessionsController < ApplicationController

  before_filter CASClient::Frameworks::Rails::Filter, only: :new
  # CAS Authentication is complete; finding corresponding user

  def new
    # First login 
    if User.find_by_username(session[:cas_user]).nil?
      @user = User.new(username: session[:cas_user], is_admin: 0, inactive: 0, real_name: session[:cas_user])
      @user.save
      redirect_to @user
      # User has already logged in before
    else
      @user = User.find_by_username(session[:cas_user])
      if @user.inactive
        @user.inactive = 0
        @user.save
      end
      flash[:notice] = "You have successfully logged in."
      redirect_to @user
    end
  end

  def destroy
    session[:cas_user] = nil
    @user = nil 
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

end
