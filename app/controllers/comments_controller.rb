class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
      #redirect_to topic_path(@topic)
    else
      flash[:danger] = "Comment was not created, Try again!"
      redirect_to :back
    end
  end
  
  
  private
  def comment_params
    params.require(:comment).permit(:description)
  end
  
end