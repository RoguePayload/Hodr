class ChatMessagesController < ApplicationController
  before_action :set_chat_chamber, only: [:index, :create]

  def create
    @chat_message = @chat_chamber.chat_messages.new(chat_message_params)
    @chat_message.user = current_user
    if @chat_message.save
      render json: @chat_message, status: :created
    else
      render json: @chat_message.errors, status: :unprocessable_entity
    end
  end

  def index
    @chat_chamber = ChatChamber.find(params[:chat_chamber_id])
    @chat_messages = @chat_chamber.chat_messages
    render partial: "chat_messages/message_list", locals: { chat_messages: @chat_messages }
  end


  private

  def set_chat_chamber
    @chat_chamber = ChatChamber.find(params[:chat_chamber_id])
  end

  def chat_message_params
    params.require(:chat_message).permit(:content, :chat_chamber_id)
  end
end
