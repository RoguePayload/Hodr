class Admin::AdsController < ApplicationController



  def index
    @ads = Ads.paginate(page: params[:page])
  end


  def new
    @ad = Ad.new
  end


    def create
      @ad = Ad.new(ad_params)
      if @ad.save
        # If the ad saves successfully, redirect to a success page
        redirect_to admin_path, notice: "Ad was successfully created."
      else
        # If the ad fails to save, render the 'new' template again to display validation errors
        render :new, status: :unprocessable_entity
      end
    end

  def edit
  end

  def update
  end

  def destroy
  end


    private

    def ad_params
      params.require(:ad).permit(:title, :subtitle, :description, :link_url, :image_url, :display_duration, :start_date, :end_date)
    end
end
