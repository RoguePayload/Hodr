class BSessionsController < ApplicationController

  def new
    # Redirect if already logged in
    if session[:business_id]
      redirect_to business_dashboard_path, notice: "You are already logged in."
    end
    # No need to explicitly render the :new template if it's the only action, Rails does it automatically.
  end

  def create
    business = Business.find_by(email: params[:email])
    if business && business.authenticate(params[:password])
      # Business is authenticated, set up session
      session[:business_id] = business.id
      redirect_to business_path(business), notice: 'Logged in successfully.'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    session[:business_id] = nil
    redirect_to root_path, notice: 'Logged out successfully.'
  end
end
