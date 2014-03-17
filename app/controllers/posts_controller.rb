class PostsController < ApplicationController

  before_filter :post_edit_priviledges, only: [:edit, :update, :destroy]
  before_filter :basic_controller_priviledges

  def show
    @post = Post.find(params[:post_id])
    @replies = Reply.post_replies(params[:post_id])
  end

  def new
    @course = Course.find(params[:course_id])
  end

  def create
    @course = Course.find(params[:course_id])
    @post = Post.new(post_params)
    @post.course_id = params[:course_id]
    @post.user_id = get_signedin_user.id
    @post.username = get_signedin_user.real_name
    
    if @post.save
      redirect_to @course
    else
      flash[:error] = "Your post could not be created. Make sure you filled out the required information."
      redirect_to new_course_post_path(@course)
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @post = Post.find(params[:id])
  end

  def update
    @course = Course.find(params[:course_id])
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to course_path(params[:course_id])
    else
      flash[:error] = "Your post could not be created. Make sure you filled out the required information."
      redirect_to edit_course_post_path(@course, @post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post.destroy
    redirect_to course_path(params[:course_id])
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end

end
