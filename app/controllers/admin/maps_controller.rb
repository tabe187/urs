class Admin::MapsController < ApplicationController
  before_action :set_q, only: [:index]
  before_action :authenticate_admin!

  def index
    @maps = @q.result.page(params[:page])
  end

  def edit
    @map = Map.find(params[:id])
  end

  def update
    @map = Map.find(params[:id])
    @map.update(map_params)
    redirect_to admin_maps_path
  end

  private

  def set_q
    @q = Map.ransack(params[:q])
  end

  def map_params
    params.require(:map).permit(:user_id, :place_name, :address, :rating, :telephone_number, :place_id, :latitude, :longitude, :map_image, :website, :types)
  end
end
