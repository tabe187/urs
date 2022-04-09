class Public::CommunitiesController < ApplicationController
  def new
    @community = Community.new
    @categories = Category.all
  end
  
  def create
    @community = Community.new(community_params)
    @community.user_id = current_user.id
    @community.save
    redirect_to community_path(@community.id)
  end
  
  def index
    @communities = Community.all
  end

  def edit
    @community = Community.find(params[:id])
    @categories = Category.all
  end

  def show
    @community = Community.find(params[:id])
  end
  
  def confirm
    @community = Community.new(community_params)
  end
  
  def update
    @community = Community.find(params[:id])
    @community.update(community_params)
    redirect_to community_path(@community.id)
  end
  
  private

  def community_params
    params.require(:community).permit(:category_id, :user_id, :title, :explanation, :community_image)
  end
  
end
