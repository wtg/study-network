class CoursesController < ApplicationController

  before_filter :basic_controller_privileges

  def show
    @course = Course.find(params[:id])
    users = User.course_registrations(params[:id])
    @users = Kaminari.paginate_array(users).page(params[:page]).per(5)
    posts = Post.course_posts(params[:id])
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(10)
  end

  def connections
    @course = Course.find(params[:course_id])
    @connections = User.course_registrations(params[:course_id])
  end

  def messages 
    @course = Course.find(params[:course_id])
    posts = Post.course_posts(params[:course_id])
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(10)
  end
  
end