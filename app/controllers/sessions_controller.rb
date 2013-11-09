class SessionsController < ApplicationController

  before_filter CASClient::Frameworks::Rails::Filter, only: :new
  # CAS Authentication is complete; finding corresponding user

  def new
    # First login 
    if User.find_by_username(session[:cas_user]).nil?
      @user = User.new(username: session[:cas_user])
      @user.save
      redirect_to @user
      # User has already logged in before
    else
      @user = User.find_by_username(session[:cas_user])
      redirect_to @user
    end
  end

  def destroy 
    CASClient::Frameworks::Rails::Filter.logout(self)
    session[:cas_user] = nil
    @user = nil
  end

end
