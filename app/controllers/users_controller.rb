class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  require 'twitch'
  require_relative '../services/twitch_service'

  def index
    # Fetch paginated users
    @users = User.paginate(page: params[:page])
  end

  def presence
    user = User.find(params[:id])
    # Example: Check if the user is considered 'online' or 'present'
    is_present = user.online? # This assumes you have a way to track if the user is online
    render json: { isPresent: is_present }
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @micropost = current_user.microposts.build if logged_in?
    @ad = Ad.where("start_date <= ? AND end_date >= ?", Date.today, Date.today).order("RANDOM()").first
    if logged_in? && current_user == @user
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    elsif logged_in? && current_user != @user
      @feed_items = @user.feed.paginate(page: params[:page])
    end
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      admin = User.find_by(id: 1)
      @user.follow(admin) unless @user == admin
      admin.follow(@user) unless @user == admin
      @user.update(last_login_at: Time.current, last_login_ip: request.remote_ip)
      log_in @user
      flash[:success] = "Welcome to MyPage!"
      @user.update(last_login_at: Time.current)
      @user.assign_all_badges
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    twitch_service = TwitchService.new(ENV['TWITCH_CLIENT_ID'])
    if @user.twitch_affiliation.present? && twitch_service.user_is_live?(@user.twitch_affiliation)
      game_title = twitch_service.get_current_game_title(@user.twitch_affiliation)
      Micropost.create(user_id: @user.id, content: "#{@user.twitch_affiliation} is now LIVE STREAMING playing #{game_title}. Come watch now: https://twitch.tv/#{@user.twitch_affiliation}")
    end
    # Check what background type the user has selected and adjust accordingly
    if params[:user][:background_type] == 'color'
      @user.background_image.detach if @user.background_image.attached?
    elsif params[:user][:background_type] == 'image'
      @user.background_color = nil
    end

    if @user.update(user_params)
      flash[:success] = "Your Page Successfully Updated!!!"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end


    def edit
      @user = User.find(params[:id])
    end

    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted."
      redirect_to admin_path # Adjust the redirect as necessary
    end


    def following
       @title = "Following"
       @user  = User.find(params[:id])
       @users = @user.following.paginate(page: params[:page])
       render 'show_follow', status: :unprocessable_entity
    end

    def followers
       @title = "Followers"
       @user  = User.find(params[:id])
       @users = @user.followers.paginate(page: params[:page])
       render 'show_follow', status: :unprocessable_entity
    end

    def edit_password
      @user = User.find(params[:id])
      unless current_user.admin?
        redirect_to(admin_path, status: :see_other) unless current_user?(@user)
      end
    end


    def update_password
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_path, notice: 'Password updated successfully.'
      else
        render :edit_password
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

      # Before filters
      # Confirms a logged-in user.
      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url, status: :see_other
        end
      end

      # Confirms the correct user.
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url, status: :see_other) unless current_user?(@user)
      end

      # Confirms an admin user.
      def admin_user
        redirect_to(root_url, status: :see_other) unless current_user.admin?
      end

      def user_is_live?(twitch_affiliation)
        response = Twitch.streams.get_streams(user_login: twitch_affiliation)
        response.data.any?
      rescue Twitch::Error::NotFound
        false
      end

      def get_current_game_title(twitch_affiliation)
        response = Twitch.streams.get_streams(user_login: twitch_affiliation)
        return unless response.data.any?

        response.data.first.game_name
      end

end
