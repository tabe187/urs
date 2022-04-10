class Public::ParticipantsController < ApplicationController
  
  def create
    community = Community.find(params[:community_id])
    participant = current_user.participants.new(community_id: community.id)
    participant.save
    redirect_to community_path(community)
  end
  
  def destroy
    community = Community.find(params[:community_id])
    participant = current_user.participants.new(community_id: community.id)
    participant.destroy
    redirect_to community_path(community)
  end
  
end
