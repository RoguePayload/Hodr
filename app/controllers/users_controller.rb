class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @micropost = current_user.microposts.build if logged_in?

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
      log_in @user
      flash[:success] = "Welcome to Hodr!"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
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
      flash[:success] = "User deleted"
      redirect_to admin_path, status: :see_other
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
          :movies, :activity, :songs, :games, :jtitle, :cname, :ljob, :jdesc, :password, :password_confirmation, :bio, :cstudies, :avatar, :banner)
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
end
