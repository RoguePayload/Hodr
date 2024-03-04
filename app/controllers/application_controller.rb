class ApplicationController < ActionController::Base
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
end
