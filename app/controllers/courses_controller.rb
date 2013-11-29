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

end