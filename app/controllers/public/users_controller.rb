class Public::UsersController < ApplicationController
  before_action :set_q, only: [:index, :search, :show, :mypage]

  def index
    @users = User.all.page(params[:page])
  end

  def search
    @results = @users_q.result
  end

  def mypage
    @user = current_user
    @maps = Map.where(user_id: [current_user.id, *current_user.following_users])
    @maps_list = Map.where(user_id: [current_user.id, *current_user.following_users]).page(params[:page])
    gon.maps = Map.where(user_id: [current_user.id, *current_user.following_users])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_mypage_path
    else
      render :edit
    end
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
    @following_users = @user.following_users
    @follower_users = @user.follower_users
    @communities = @user.participants.last(5)
    @maps = @user.favorites.page(params[:page])
  end


  def follows
    user = User.find(params[:id])
    @users = user.following_users.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_users.page(params[:page]).per(3).reverse_order
  end

  def communities
    user = User.find(params[:id])
    @users = user.participants.page(params[:page]).per(3).reverse_order
  end

  private

  def set_q
    @users_q = User.ransack(params[:users_q], search_key: :users_q)
    @maps_q = Map.ransack(params[:maps_q], search_key: :maps_q)
  end

  def user_params
    params.require(:user).permit(:name, :email, :region, :city, :hobby, :profile, :birthday_year, :birthday_month, :birthday_day, :gender, :is_active, :profile_image, :is_deleted)
  end

end
