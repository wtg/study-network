class RepliesController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @course = Course.find(params[:course_id])
    @reply = Reply.new(reply_params)
    @reply.post_id = @post.id
    if @reply.save
      redirect_to new_course_post_reply_path(course_id: @course.id, post_id: @post.id)
    else
      redirect_to new_course_post_reply_path(@post)
    end
  end

  private 
    def reply_params
      params.require(:new_course_post_reply).permit(:body)
    end 

end
