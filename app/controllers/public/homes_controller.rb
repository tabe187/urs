class Public::HomesController < ApplicationController

  def top
    @users = User.all.last(12)
    @maps_restaurant =  Map.includes(:favorites).where(types: 'restaurant').sort {|a,b| b.favorites.size <=> a.favorites.size}.first(5)
    @maps_bar =  Map.includes(:favorites).where(types: 'bar').sort {|a,b| b.favorites.size <=> a.favorites.size}.first(5)
    @maps_night_club =  Map.includes(:favorites).where(types: 'night_club').sort {|a,b| b.favorites.size <=> a.favorites.size}.first(5)
    @maps_park =  Map.includes(:favorites).where(types: 'park').sort {|a,b| b.favorites.size <=> a.favorites.size}.first(5)
    @maps_cafe =  Map.includes(:favorites).where(types: 'cafe').sort {|a,b| b.favorites.size <=> a.favorites.size}.first(5)
    @maps_hotel =  Map.includes(:favorites).where(types: 'hotel').sort {|a,b| b.favorites.size <=> a.favorites.size}.first(5)
    @maps_hot_spring =  Map.includes(:favorites).where(types: 'hot_spring').sort {|a,b| b.favorites.size <=> a.favorites.size}.first(5)
    @maps_other =  Map.includes(:favorites).where(types: 'other').sort {|a,b| b.favorites.size <=> a.favorites.size}.first(5)
    @communities = Community.all.last(12)
    gon.maps = Map.all
  end

  def about
    gon.maps = Map.all
  end

end
