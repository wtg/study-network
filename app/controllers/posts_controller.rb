class PostsController < ApplicationController

  def show
    @post = Post.find(params[:post_id])
    @replies = Reply.post_replies(params[:post_id])
    @user = get_signedin_user
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

  private
    def post_params
      params.require(:new_course_posts).permit(:title, :body)
    end

end
