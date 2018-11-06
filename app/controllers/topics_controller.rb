class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :like]
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
   
    @comment = Comment.new
    @comments = @topic.comments
  end
  
  def edit
     
  end
  
  def update
    
     if @topic.update(topic_params)
       flash[:success] = "Topic was updated"
       redirect_to topic_path(@topic)
     else
       render 'edit'
     end
  end
  
  def destroy
    
    @topic.destroy
    flash[:danger] = "Topic deleted"
    redirect_to topics_path
  end
  
  def like
    like = Like.create(like: params[:like], user: current_user, topic: @topic)
    if like.valid?
      flash[:info] = "Liked!"
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a comment once.."
      redirect_to :back
    end
  end
  
  
  private
  
  def topic_params
    params.require(:topic).permit(:name, :description, :picture)
  end
  
  def set_topic
     @topic = Topic.find(params[:id])
  end
  
  def require_same_user
    if current_user != @topic.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own Blogs"
      redirect_to topics_path
    end
  end
  
  def require_user_like
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to :back
    end
  end
  
end