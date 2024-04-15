# app/controllers/chat_chambers_controller.rb
class ChatChambersController < ApplicationController
  # Ensure user is logged in for most actions
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  # Check if the current user is authorized to modify a chat chamber
  before_action :set_chat_chamber, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /chat_chambers
  # Displays all chat chambers or filters them by category if specified
  def index
    @categories = ChatChamber.distinct.pluck(:category)
    if params[:category].present?
      @chat_chambers = ChatChamber.where(category: params[:category])
    else
      @chat_chambers = ChatChamber.all
    end
  end

  # GET /chat_chambers/:id
  # Shows a specific chat chamber, including its messages
  def show
    @chat_chamber = ChatChamber.find(params[:id])
    @chat_messages = @chat_chamber.chat_messages.includes(:user)
    @chat_message = ChatMessage.new  # This is for the form to send a new message
  end

  # GET /chat_chambers/new
  # Initializes a new chat chamber object for the new chamber form
  def new
    @chat_chamber = ChatChamber.new
  end

  # POST /chat_chambers
  # Creates a new chat chamber from the form parameters
  def create
    @chat_chamber = current_user.chat_chambers.build(chat_chamber_params)
    if @chat_chamber.save
      redirect_to @chat_chamber, notice: 'Chat Chamber was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /chat_chambers/:id/edit
  # Prepares an existing chat chamber for editing
  def edit
  end

  # PATCH/PUT /chat_chambers/:id
  # Updates an existing chat chamber with new information from the form
  def update
    if @chat_chamber.update(chat_chamber_params)
      redirect_to @chat_chamber, notice: 'Chat Chamber was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /chat_chambers/:id
  # Destroys a chat chamber and redirects to the chat chamber list
  def destroy
    # Delete associated records before destroying the chat chamber
    @chat_chamber.chat_messages.destroy_all
    @chat_chamber.destroy

    redirect_to chat_chambers_url, notice: 'Chat Chamber was successfully destroyed.'
  end


  private

  # Finds a chat chamber based on the ID from the URL parameters
  def set_chat_chamber
    @chat_chamber = ChatChamber.find(params[:id])
  end

  # Redirects unless the current session user is the one who created the chamber or an admin
  def correct_user
    redirect_to(root_url) unless current_user == @chat_chamber.user || current_user.admin?
  end

  # Ensures the user is logged in
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Sanitizes the input from the form, allowing only certain parameters
  def chat_chamber_params
    permitted_params = [:name, :description, :category]
    permitted_params += [:password, :avatar] if current_user.is_premium?
    params.require(:chat_chamber).permit(*permitted_params)
  end
end
