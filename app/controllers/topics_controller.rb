class TopicsController < ApplicationController
  before_action :require_user, except: [:index, :show]
  #before_action :require_same_user, only: [:edit, :update, :destroy]
  
  
  def index
    @topics = Topic.all
  end
  
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
   if @topic.save
      flash[:success] = "post sucessfully created"
      redirect_to topic_path(@topic)
   else
    render 'new'
   end
   
  end
  
  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    @comments = @topic.comments
  end
  
  def edit
     @topic = Topic.find(params[:id])
  end
  
  def update
     @topic = Topic.find(params[:id])
     if @topic.update(topic_params)
       flash[:success] = "Topic was updated"
       redirect_to topic_path(@topic)
     else
       render 'edit'
     end
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    flash[:danger] = "Topic deleted"
    redirect_to topics_path
  end
  
  private
  
  def topic_params
    params.require(:topic).permit(:name, :description, :picture)
  end
  
  def require_same_user
    if current_user != @topic.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own Blogs"
      redirect_to topics_path
    end
  end
  
end