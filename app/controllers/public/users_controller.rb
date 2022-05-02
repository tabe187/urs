class Public::UsersController < ApplicationController
  before_action :set_q, only: [:index, :search]

  def index
    @users = User.all
  end

  def search
    @results = @q.result
  end

  def mypage
    @user = current_user
    @maps = Map.where(user_id: [current_user.id, *current_user.following_user])
    @users = @user.following_user.page(params[:page]).per(3).reverse_order
    gon.maps = Map.where(user_id: [current_user.id, *current_user.following_user])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_customer
    @user.update(user_params)
    redirect_to users_mypage_path
  end

  def unsubscribe
    @user = current_user
  end

  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
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

  def set_q
    @q = User.ransack(params[:q])
  end

  def user_params
    params.require(:user).permit(:name, :email, :region, :city, :hobby, :profile, :birthday_year, :birthday_month, :birthday_day, :gender, :is_active, :profile_image, :is_deleted)
  end

end
