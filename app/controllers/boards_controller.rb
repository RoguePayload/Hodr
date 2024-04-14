class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category_id].present?
      @boards = Board.where(category_id: params[:category_id])
    else
      @boards = Board.all
    end
    @categories = Category.all
  end

  def show
    @message = Message.new
    @messages = @board.messages.order(created_at: :asc)
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.invite_link = generate_invite_link

    if @board.save
      redirect_to @board, notice: 'Board was successfully created.'
    else
      render :new
    end
  end

  def edit
    unless current_user.admin? || current_user == @board.owner
      redirect_to @board, alert: 'You are not authorized to edit this board.'
    end
  end

  def update
    if @board.update(board_params)
      redirect_to @board, notice: 'Board was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, notice: 'Board was successfully deleted.'
  end

  private

  def generate_invite_link
    SecureRandom.hex(10) # Generate a random hexadecimal string of length 10
  end  

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    if current_user.is_premium? || current_user.admin?
      params.require(:board).permit(:name, :avatar, :description, :category_id, :password, :invite_link)
    else
      params.require(:board).permit(:name, :description, :category_id, :invite_link)
    end
  end
end
