class Public::HomesController < ApplicationController

  def top
    @users = User.all
    @maps = Map.all
    @communities = Community.all
    @comments = Comment.all
    @favorites = Favorite.all
  end

  def about
  end



end
