class Public::HomesController < ApplicationController

  def top
    @users = User.all
    @maps_restaurant =  Map.includes(:favorites).where(types: 'restaurant').sort {|a,b| b.favorites.size <=> a.favorites.size}.first(5)
    @maps_bar =  Map.includes(:favorites).where(types: 'night_club').sort {|a,b| b.favorites.size <=> a.favorites.size}.first(5)
    @maps_park =  Map.includes(:favorites).where(types: 'park').sort {|a,b| b.favorites.size <=> a.favorites.size}.first(5)
    @communities = Community.all
    gon.maps = Map.all
  end

  def about
  end

end
