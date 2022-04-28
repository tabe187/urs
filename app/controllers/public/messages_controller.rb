class Public::MessagesController < ApplicationController

  def index
  @message = Message.new
  @room = Room.find(params[:room_id])
  @messages = @room.messages.includes(:user)
  end


  def create
  @room = Room.find(params[:room_id])
  @message = @room.messages.new(message_params)
  @messages = @room.messages.includes(:user)
  @message.save
  end


private

  def message_params
  params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

end
