class CoursesController < ApplicationController

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

private
  def course_params
    params.require(:course).permit(:title, :crn, :abrev_name, :level, :section)
  end

end