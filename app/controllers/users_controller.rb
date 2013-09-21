class UsersController < ApplicationController

  before_filter :signed_in?

  def index
  end

  def show
    @user = User.find_by_username(session[:cas_user])
  end

end
