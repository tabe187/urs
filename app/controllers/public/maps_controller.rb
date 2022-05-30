class Public::MapsController < ApplicationController
  before_action :set_q, only: [:index, :search_keyword, :search]
  before_action :authenticate_user!, only: [:create]

  def index
    @maps = @q.result.page(params[:page])
  end

  def new
    @map = Map.new
    @maps = Map.all
  end

  def show
    @map = Map.find(params[:id])
    @reviews = @map.reviews.order(created_at: "DESC")
    @map_users = @map.favorites.joins(:user).where(users: { is_deleted: false }).page(params[:page])
    @review = Review.new
  end

  def create
    @map = Map.find_by(place_id: params[:map][:place_id])
    @favorite = current_user.favorites.find_by(user_id: params[:map][:user_id])
    if @map && @favorite
      redirect_to users_mypage_path
    elsif @map
      @favorite = Favorite.new
      @favorite.map_id = @map.id
      @favorite.user_id = current_user.id
      @favorite.save
      redirect_to users_mypage_path
    else
      @map = Map.new(map_params)
      @map.user_id = current_user.id
      @map.save
      @favorite = Favorite.new
      @favorite.map_id = @map.id
      @favorite.user_id = current_user.id
      @favorite.save
      redirect_to users_mypage_path
    end
  end

  def search_keyword
    @results = @q.result
  end

  private

  def set_q
    @q = Map.ransack(params[:q])
  end

  def map_params
    params.require(:map).permit(:user_id, :place_name, :address, :rating, :telephone_number, :place_id, :latitude, :longitude, :map_image, :website, :types)
  end

  def favorite_params
    params.require(:favorite).permit(:user_id, :map_id,)
  end
end
