class Public::TopicsController < ApplicationController
  def new
    @community = Community.find(params[:community_id])
    @topic = Topic.new
  end
  
  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    if @topic.save
    redirect_to community_topic_path(@topic.community.id, @topic.id)
    else
    render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @comments = Comment.all
    @comment = Comment.new
  end

  def edit
  end

  private

  def topic_params
    params.require(:topic).permit(:community_id, :user_id, :title, :explanation, :topic_image)
  end

end
