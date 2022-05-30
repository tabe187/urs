class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to community_topic_path(@comment.topic.community.id, @comment.topic.id)
    else
      @topic = Topic.find(params[:topic_id])
      render template: "public/topics/show"
    end
  end

  def edit
    @comment =Comment.find(params[:id])
    if current_user != @comment.user_id
      redirect_back fallback_location: root_path
    end  
  end

  def update
    @comment =Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to community_topic_path(@comment.topic.community.id, @comment.topic.id)
    else
      @topic = Topic.find(params[:topic_id])
      render :edit
    end
  end

  def destroy
    @comment =Comment.find(params[:id])
    @comment .destroy
    redirect_to community_topic_path(@comment.topic.community.id, @comment.topic.id)
  end


  private

  def comment_params
      params.require(:comment).permit(:topic_id, :user_id, :comment, :comment_image)
  end
end

