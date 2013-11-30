class CoursesController < ApplicationController

  before_filter :authorize_admins_only, except: [:show]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    registered_students = Registration.where(course_id: params[:id])
    @users = User.joins(:registrations).where(users: {inactive: false}, registrations: {course_id: params[:id]})
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