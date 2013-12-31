class RegistrationsController < ApplicationController

  def index
    @registrations = Registration.find_by_user_id(params[:user_id])
  end

  def new
    @user = User.find(params[:user_id])
    @courses = Course.find(:all)
    @departments = Course.uniq.pluck(:abrev_name)
  end

  def create
    @user = User.find(params[:user_id])
    registrations = params[:new_course_registrations][:registrations]
    registrations.each do |acrn| 
      Registration.create(course_id: Course.find_by_crn(acrn).id, 
                          user_id: params[:user_id].to_i)
    end
    redirect_to @user
  end

  private
    def user_params
      params.require(:registration).permit(:user_id, :new_course_registrations)
    end

end
