class JobsController < ApplicationController

  before_action :set_business

  def new
    @job = @business.jobs.build
  end

  def create
    @job = @business.jobs.build(job_params)
    if @job.save
      redirect_to business_path(@business), notice: 'Job listing was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  private

  def set_business
    @business = Business.find(params[:business_id])
  end

  def job_params
    params.require(:job).permit(:jname, :jdesc, :jpay, :jlink)
  end
end
