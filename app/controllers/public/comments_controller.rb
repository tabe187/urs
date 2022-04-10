class Public::CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to community_topic_path(@comment.topic.community.id, @comment.topic.id)
  end

  private

  def comment_params
      params.require(:comment).permit(:topic_id, :user_id, :comment, :comment_image)
  end
end

