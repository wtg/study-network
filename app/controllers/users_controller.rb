class UsersController < ApplicationController

  before_filter :authorize_admins_only, only: [:new, :create, :index]

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to @user
  end

  def show
    if User.exists? id: params[:id]
      @user = User.find(params[:id])
      if @user.inactive
        redirect_to '/'
      end
      @classes = Registration.where(user_id: @user.id)
    else
      redirect_to '/'
    end
  end

  def edit
    @user = User.find(params[:id])
    @registrations = Registration.where(user_id: @user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.inactive = 1
    @user.save
    redirect_to sign_out_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :real_name, :year, :is_admin, :email)
    end

end
