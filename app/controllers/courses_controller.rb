class CoursesController < ApplicationController

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    registered_students = Registration.where(course_id: params[:id])
    @users = Array.new
    if registered_students.length > 0 
      registered_students.each do |rs|
        aUser = User.find(rs.user_id)
        if not aUser.inactive
          @users << aUser
        end
      end
    end
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