class Public::FavoritesController < ApplicationController

  def create
    map = Map.find(params[:map_id])
    favorite = current_user.favorites.new(map_id: map.id)
    favorite.save

    redirect_to map_path(map.id)
  end
  
  def destroy
    map = Map.find(params[:map_id])
    favorite = current_user.favorites.find_by(map_id: map.id)
    favorite.destroy
    
    redirect_to map_path(map.id)
  end
end
