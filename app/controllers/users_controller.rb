class UsersController < ApplicationController

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
    @user = User.find(params[:id])
    @classes = Registration.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :real_name, :year)
    end

end
