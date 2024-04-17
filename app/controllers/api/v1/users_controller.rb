class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_key
  
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: "Account created successfully" }, status: :created
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      render json: { message: "Login successful", user: @user }, status: :ok
    else
      render json: { error: "Invalid email/password combination" }, status: :unauthorized
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user, include: [:microposts], status: :ok
  end

  def index
    @users = User.paginate(page: params[:page])
    render json: @users, status: :ok
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:uname, :fname, :mname, :lname, :tel, :email, :adr1, :adr2, :city, :state, :zip, :country, :git, :twitter, :ytube, :lin, :web, :degree, :sname, :cstudies, :marital, :spouse, :kids, :books,
      :movies, :activity, :songs, :games, :jtitle, :cname, :ljob, :jdesc, :password, :password_confirmation, :bio, :cstudies, :avatar, :banner,:background_image, :background_music, :background_color,
                           :heading_font, :paragraph_font, :hyperlink_font,
                           :heading_color, :paragraph_color, :hyperlink_color,
                           :twitch_affiliation, :youtube_affiliation, :premium_user,
                           :box_shadow, :box_shadow_color, :privacy,
                           :verification_badge, :admin_badge, :button_color,
                           :button_outline, :remove_background_music, :other_attributes)
  end

  def authenticate_api_key
    api_key = request.headers['X-API-Key']
    unless api_key && User.exists?(api_key: api_key)
      render json: { error: 'Invalid API key' }, status: :unauthorized
    end
  end
end
