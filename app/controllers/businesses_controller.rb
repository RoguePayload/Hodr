class BusinessesController < ApplicationController

  before_action :set_business, only: [:show, :edit, :update]

  def index
    @businesses = Business.paginate(page: params[:page], per_page: 10) # Adjust `per_page` as needed
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    if @business.save
      redirect_to @business, notice: 'Business profile was successfully created.'
    else
      render :new
    end
  end

  def show
    @business = Business.find(params[:id])
  end

  def edit
    @business = Business.find(params[:id])
  end

  def update
    if @business.update(business_params)
      redirect_to @business, notice: 'Business profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_business
    @business = Business.find(params[:id])
  end

  def business_params
    params.require(:business).permit(:name, :website, :avatar, :banner, :address, :city, :state, :zip, :email, :phone, :password, :password_confirmation)
  end

end
