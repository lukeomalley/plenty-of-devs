class MessagesController < ApplicationController
  def create
    message = Message.create(message_params)
    redirect_to chat_path(message.chat)
  end

  private

  def message_params
    params.require(:message).permit(:chat_id, :user_id, :content)
  end
end
