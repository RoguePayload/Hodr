class BoardsController < ApplicationController
  before_action :set_board, only: [:show]

  def index
    if params[:category_id].present?
      @boards = Board.where(category_id: params[:category_id])
    else
      @boards = Board.all
    end
    @categories = Category.all # For the dropdown
  end


  def show
    @message = Message.new # For the message form on the board's page
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to @board, notice: 'Board was successfully created.'
    else
      render :new
    end
  end

  def messages
    @board = Board.find(params[:id])
    render partial: 'messages', locals: { messages: @board.messages }
  end

  def destroy
    @board = Board.find(params[:id])
    Rails.logger.debug "Deleting board: #{@board.inspect}"
    @board.destroy
    redirect_to boards_path, notice: 'Board was successfully deleted.'
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.debug "Board not found: #{e.inspect}"
    redirect_to boards_path, alert: 'Board not found.'
  end

  def fetch_messages
    @board = Board.find(params[:id])
    @messages = @board.messages.order(created_at: :asc) # Assuming you have a `messages` association
    render partial: 'messages', locals: { messages: @messages }, layout: false
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :avatar, :description, :category_id)
  end



end
