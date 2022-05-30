class Public::MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index]

  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
    @room_owner = @room.users.where.not(id: current_user.id).first.name
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    @messages = @room.messages.includes(:user)
    @message.save
  end

  private

  def message_params
    params.require(:message).permit(:content, :message_image).merge(user_id: current_user.id)
  end
end
