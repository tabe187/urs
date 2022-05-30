class Public::TopicsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to community_topic_path(@topic.community.id, @topic.id)
    else
      @community = Community.find(params[:community_id])
      render template: "public/communities/show"
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @comments = @topic.comments.order(created_at: "DESC")
    @comment = Comment.new
  end

  def edit
    @topic = Topic.find(params[:id])
    if current_user != @topic.user_id
      redirect_back fallback_location: root_path
    end
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      redirect_to community_topic_path(@topic.community.id, @topic.id)
    else
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to community_path(@topic.community.id)
  end

  private

  def topic_params
    params.require(:topic).permit(:community_id, :user_id, :title, :explanation, :topic_image)
  end
end
