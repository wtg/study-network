class RegistrationsController < ApplicationController

  before_filter :registrations_priviledges

  def search_courses
    @courses = Course.search(params[:search])
  end

  def index
    @registrations = Registration.where(user_id: params[:user_id])
  end

  def new
    @user = User.find(params[:user_id])
    @courses = Course.find(:all)
    @departments = Course.uniq.pluck(:abrev_name)
  end

  def create
    @user = User.find(params[:user_id])
    if params[:new_course_registrations] != nil
      registrations = params[:new_course_registrations][:registrations]
      registrations.each do |aTitle| 
        Registration.create(course_id: Course.find_by_title(aTitle).id, 
                            user_id: params[:user_id].to_i)
      end
      flash[:notice] = "Registration successful." 
      redirect_to user_registrations_path
    else
      flash[:error] = "Oops! You didn't select any classes."
      redirect_to user_registrations_path
    end
   
  end

  def edit
    @registration = Registration.find(params[:id])
    @registration.destroy
    redirect_to user_registrations_path(params[:user_id])
  end

  def dept
    @department = params[:dept]
    @courses = Course.department_courses(@department)
  end

  private
    def user_params
      params.require(:registration).permit(:user_id, :new_course_registrations)
    end

end