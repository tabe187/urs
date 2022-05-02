class Public::RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms
  end
  
  def new
    @room = Room.new
  end
  
  def create
    current_user.rooms.each do |room|
      another_user = room.users.find_by(id: params[:another_user_id])
      if another_user
        return redirect_to room_messages_path(room)
      end
    end
    @room = Room.create!
    RoomUser.create(user_id: current_user.id, room_id: @room.id)
    RoomUser.create(user_id: params[:another_user_id], room_id: @room.id)
    redirect_to room_messages_path(@room)
  end

private

  # def room_params
  #   params.permit(user_ids: [])
  # end
  
end
