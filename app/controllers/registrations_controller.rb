class RegistrationsController < ApplicationController

  def index
    @registrations = Registration.where(user_id: params[:user_id])
  end

  def new
    @user = User.find(params[:user_id])
    @courses = Course.find(:all)
    all_departments = Course.uniq.pluck(:abrev_name)
    @department_groups = Array.new()
    all_departments.in_groups(2, nil) { |dept_group| @department_groups << dept_group}
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

  def edit
    @registration = Registration.find(params[:id])
    @registration.destroy
    redirect_to user_registrations_path(params[:user_id])
  end

  private
    def user_params
      params.require(:registration).permit(:user_id, :new_course_registrations)
    end

end
