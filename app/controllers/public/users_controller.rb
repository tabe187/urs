class Public::UsersController < ApplicationController
  def index
    @users = User.all
  end  
  
  def mypage
    @user = current_user
  end  

  def show
    @user = User.find(params[:id])
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end
  
  def update
    @user = current_user
    @user.update(user_params)
    redirect_to users_mypage_path
  end
  
  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end
  

  
  private

  def user_params
    params.require(:user).permit(:name, :email, :region, :city, :birthday_year, :birthday_month, :birthday_day, :gender, :is_active, :profile_image)
  end
  
end
