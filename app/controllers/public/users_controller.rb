class Public::UsersController < ApplicationController
  before_action :set_q, only: [:index, :search, :show, :mypage]
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy, :mypage, :unsubscribe, :withdrawal]

  def index
    @users = User.where(is_deleted: [false]).page(params[:page])
  end

  def mypage
    @user = current_user
    @map_restaurants =  @user.favorites.joins(:map).where(maps: {types: 'restaurant'}).last(5)
    @map_bars =  @user.favorites.joins(:map).where(maps: {types: 'bar'}).last(5)
    @map_parks =  @user.favorites.joins(:map).where(maps: {types: 'park'}).last(5)
    @maps_list = @user.favorites.page(params[:page])
    gon.maps = Map.where(user_id: [current_user.id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user)
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
    if @user.is_deleted == true
      flash[:notice] = "このユーザーは退会済みです"
      redirect_back fallback_location: root_path

    else
      @following_users = @user.following_users.where(is_deleted: [false]).last(6)
      @follower_users = @user.follower_users.where(is_deleted: [false]).last(6)
      @communities = @user.participants.last(6)
      @maps = @user.favorites.page(params[:page])
    end
  end


  def follows
    user = User.find(params[:id])
    @users = user.following_users.where(is_deleted: [false]).page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_users.where(is_deleted: [false]).page(params[:page]).per(3).reverse_order
  end

  def communities
    user = User.find(params[:id])
    @users = user.participants.page(params[:page]).per(3).reverse_order
  end

  def search
    @results = @q.result
  end

  private

  def set_q
    @q = User.where(is_deleted: [false]).ransack(params[:q])
    @maps_q = Map.ransack(params[:maps_q], search_key: :maps_q)
  end

  def user_params
    params.require(:user).permit(:name, :email, :region, :city, :hobby, :profile, :birthday_year, :birthday_month, :birthday_day, :gender, :is_active, :profile_image, :is_deleted)
  end

end
