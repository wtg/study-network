class PostsController < ApplicationController

  def new
    @course = Course.find(params[:course_id])
  end

  def create
    @course = Course.find(params[:course_id])
    @post = Post.new(post_params)
    @post.course_id = params[:course_id]
    if @post.save
      redirect_to @course
    else
      redirect_to new_course_post_path(@course)
    end
  end

  private
    def post_params
      params.require(:new_course_posts).permit(:title, :body)
    end

end
