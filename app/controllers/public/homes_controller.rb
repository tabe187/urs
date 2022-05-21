class Public::HomesController < ApplicationController

  def top
    @users = User.all.last(12)
    @map_restaurants =  Map.includes(:favorites).where(types: 'restaurant').sort {|a,b| b.favorites.size <=> a.favorites.size}.last(5)
    @map_bars =  Map.includes(:favorites).where(types: 'bar').sort {|a,b| b.favorites.size <=> a.favorites.size}.last(5)
    @map_night_clubs =  Map.includes(:favorites).where(types: 'night_club').sort {|a,b| b.favorites.size <=> a.favorites.size}.last(5)
    @map_parks =  Map.includes(:favorites).where(types: 'park').sort {|a,b| b.favorites.size <=> a.favorites.size}.last(5)
    @map_cafes =  Map.includes(:favorites).where(types: 'cafe').sort {|a,b| b.favorites.size <=> a.favorites.size}.last(5)
    @map_hotels =  Map.includes(:favorites).where(types: 'hotel').sort {|a,b| b.favorites.size <=> a.favorites.size}.last(5)
    @map_hot_springs =  Map.includes(:favorites).where(types: 'hot_spring').sort {|a,b| b.favorites.size <=> a.favorites.size}.last(5)
    @map_others =  Map.includes(:favorites).where(types: 'other').sort {|a,b| b.favorites.size <=> a.favorites.size}.last(5)
    @communities = Community.all.last(12)
    gon.maps = Map.all
  end

end
