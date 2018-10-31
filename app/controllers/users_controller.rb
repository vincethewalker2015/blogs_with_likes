class UsersController < ApplicationController
  #before_action :require_user, except: [:new, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
   if @user.save
      session[:user_id] = @user.id
      cookies.signed[:user_id] = @user.id
      flash[:success] = "Your Profile has been created"
      redirect_to user_path(@user)
   else
     flash.now[:danger] = "Opps! Something went wrong, Try again.."
     render 'new'
   end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
     @user = User.find(params[:id])
     if @user.update(user_params)
       flash.now[:success] = "User Details updated"
       redirect_to user_path(@user)
     else
       render 'edit'
     end
  end
  
  def destroy
   @user = User.find(params[:id])
   @user.destroy
   flash[:danger] = "User has been deleted"
   redirect_to users_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :picture, :password, :password_confirmation)
  end
  
  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:warning] = "You can only edit or delete your own profile.."
      redirect_to users_path
    end
  end
  
  def require_admin
    if logged_in? && !current_user.admin?
      flash[:warning] = "Only admin users can perform this action"
      redirect_to root_path
    end
  end
  
  
end