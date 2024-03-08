class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications
  end

  def mark_as_read
    notification = Notification.find(params[:id])
    notification.update!(read_at: Time.current) if notification.user == current_user
    redirect_back(fallback_location: notifications_path)
  end


end
