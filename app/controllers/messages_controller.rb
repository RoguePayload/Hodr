class MessagesController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    @message = @board.messages.new(message_params.merge(user: current_user)) # Assumes you have a method to get the current user

    if @message.save
      redirect_to @board, notice: 'Message was successfully posted.'
    else
      redirect_to @board, alert: 'Unable to post the message.'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image)
  end
end
