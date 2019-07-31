class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
  end

  def create
    chat = Chat.find_or_create_by(match_id: params[:match_id])
    redirect_to chat_path(chat)
  end
end
