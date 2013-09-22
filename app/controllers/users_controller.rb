class UsersController < ApplicationController

  def index
  end

  def show
    if signed_in?
      @user = User.find_by_username(session[:cas_user])
    else
      redirect_to '/'
    end
  end

end
