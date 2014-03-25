class RepliesController < ApplicationController

  before_filter :reply_edit_privileges
  before_filter :basic_controller_privileges

  def new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @course = Course.find(params[:course_id])
    @reply = Reply.new(reply_params)
    @reply.post_id = @post.id
    @reply.user_id = get_signedin_user.id
    if @reply.save
      redirect_to course_post_path(id: @post.id, course_id: @course.id, post_id: @post.id)
    else
      redirect_to new_course_post_reply_path(@post)
    end
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy
    redirect_to course_post_path(course_id: params[:course_id], post_id: params[:post_id])
  end

  private 
    def reply_params
      params.require(:new_course_post_reply).permit(:body)
    end 

end