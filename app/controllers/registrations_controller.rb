class RegistrationsController < ApplicationController

  def index
    @registrations = Registration.find_by_user_id(params[:user_id])
  end

  def new
    @user = User.find(params[:user_id])
    @courses = Course.find(:all)
  end

  def create
    @user = User.find(params[:user_id])
    registered_crns = params[:new_course_registrations][:registrations]
    registered_crns.each do |acrn| 
      Registration.create(course_id: Course.find_by_crn(acrn), 
                          user_id: params[:user_id])
    end
    redirect_to @user
  end

  private
    def user_params
      params.require(:registration).permit(:user_id, :new_course_registrations)
    end

end
