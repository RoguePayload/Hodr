class BusinessesController < ApplicationController

  before_action :set_business, only: [:show, :edit, :update, :destroy, :index]
  before_action :admin_user,     only: :destroy


  def index
    @businesses = Business.paginate(page: params[:page], per_page: 10) # Adjust `per_page` as needed
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    if @business.save
      @user.update(last_login_at: Time.current, last_login_ip: request.remote_ip)
      redirect_to @business, notice: 'Business profile was successfully created.'
    else
      render :new
    end
  end

  def show
    @business = Business.find(params[:id])
    @business.update(last_login_ip: request.remote_ip)
  end

  def edit
    @business = Business.find(params[:id])
  end

  def update
    if @business.update(business_params)
      @user.update(last_login_at: Time.current)
      redirect_to @business, notice: 'Business profile was successfully updated.'
    else
      render :edit
    end
  end

  def edit_password
    @business = Business.find(params[:id])
    unless current_business.admin?
      redirect_to(admin_path, status: :see_other) unless current_business?(@business)
    end
  end

  def update_password
    @business = Business.find(params[:id])
    if @business.update(business_params)
      redirect_to admin_path, notice: 'Password updated successfully.'
    else
      render :edit_password
    end
  end

  private

  def set_business
    @business = Business.find(params[:id])
  end

  def business_params
    params.require(:business).permit(:name, :website, :avatar, :banner, :address, :city, :state, :zip, :email, :phone, :password, :password_confirmation)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url, status: :see_other) unless current_user.admin?
  end

end
