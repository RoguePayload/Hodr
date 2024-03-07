class ApplicationController < ActionController::Base
  helper_method :current_business # Makes the method available in views
  include SessionsHelper
  before_action :detect_device_variant
  helper_method :mobile_view?, :desktop_view?

  private
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end

    def detect_device_variant
      request.variant = :mobile if browser.device.mobile?
    end

    def mobile_view?
      request.user_agent =~ /Mobile|webOS/
    end

    def desktop_view?
      !mobile_view?
    end

    def current_business
      @current_business ||= Business.find(session[:business_id]) if session[:business_id]
    rescue ActiveRecord::RecordNotFound
      session[:business_id] = nil # Handles edge case where business does not exist
    end    
end
