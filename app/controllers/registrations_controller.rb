class RegistrationsController < ApplicationController

  def index
    @registrations = Registration.find_by_user_id(params[:user_id])
  end

  def new
    @user = User.find(params[:user_id])
  end

  def create
  end

  private
    def user_params
      params.require(:registration).permit(:user_id)
    end

end
