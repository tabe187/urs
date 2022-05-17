class Public::ParticipantsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  
  def create
    community = Community.find(params[:community_id])
    participant = current_user.participants.new(community_id: community.id)
    participant.save
    community.create_notification_like!(current_user)
    redirect_to community_path(community)
  end
  
  def destroy
    community = Community.find(params[:community_id])
    participant = current_user.participants.find_by(community_id: community.id)
    participant.destroy
    redirect_to community_path(community)
  end
  
end
