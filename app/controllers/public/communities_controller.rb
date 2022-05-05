class Public::CommunitiesController < ApplicationController
  before_action :set_q, only: [:index, :search]
  
  def new
    @community = Community.new
    @categories = Category.all
  end

  def create
    @community = Community.new(community_params)
    @community.user_id = current_user.id
    @community.save
    @participant = Participant.new
    @participant.community_id = @community.id
    @participant.user_id = current_user.id
    @participant.save
    redirect_to community_path(@community.id)
  end

  def index
    @communities = Community.all.page(params[:page])
  end

  def edit
    @community = Community.find(params[:id])
    @categories = Category.all
  end

  def show
    @community = Community.find(params[:id])
    @topic = Topic.new
  end

  def update
    @community = Community.find(params[:id])
    @community.update(community_params)
    redirect_to community_path(@community.id)
  end

  def destroy
    @community = Community.find(params[:id])
    @community.destroy
    redirect_to communities_path
  end

  def search
    @results = @q.result
  end

  private

  def set_q
    @q = Community.ransack(params[:q])
  end

  def community_params
    params.require(:community).permit(:category_id, :user_id, :title, :explanation, :community_image)
  end

  def topic_params
    params.require(:topic).permit(:community_id, :user_id, :title, :explanation, :topic_image)
  end

  def participant_params
    params.require(:participant).permit(:community_id, :user_id)
  end

end
