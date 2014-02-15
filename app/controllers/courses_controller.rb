class CoursesController < ApplicationController

  before_filter :authorize_admins_only, except: [:show, :connections, :messages]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    users = User.joins(:registrations).where(users: {inactive: false}, registrations: {course_id: params[:id]}).shuffle!
    @users = Kaminari.paginate_array(users).page(params[:page]).per(5)
    posts = Post.where(course_id: params[:id])
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(10)
  end

  def connections
    @course = Course.find(params[:course_id])
    @connections = User.joins(:registrations).where(users: {inactive: false}, registrations: {course_id: params[:course_id]}).shuffle!
  end

  def messages 
    @course = Course.find(params[:course_id])
    posts = Post.where(course_id: params[:course_id])
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(10)
  end

  def new
  end

  def create
    @course = Course.new(course_params)
    @course.save
    redirect_to @course
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to @course
    else
      render 'edit'
    end
  end

private
  def course_params
    params.require(:course).permit(:title, :crn, :abrev_name, :level, :section)
  end
  
end