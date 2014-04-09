class PagesController < ApplicationController

  def home
    @user = User.find_by_username(session[:cas_user])
    if @user
      @courses = User.registered_courses(@user)
    end
  end

  def search
    @users = User.search(params[:search])
    @courses = Course.search(params[:search])
  end

end
