class ApplicationController < ActionController::Base
  helper_method :current_business # Makes the method available in views
  include SessionsHelper
  before_action :detect_device_variant
  helper_method :mobile_view?, :desktop_view?
  before_action :fetch_unread_notifications
  helper_method :current_user, :user_signed_in?

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

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def user_signed_in?
      !!current_user
    end

    def fetch_unread_notifications
      if user_signed_in?
        @unread_notifications = current_user.notifications.where(read_at: nil)
      end
    end



end
