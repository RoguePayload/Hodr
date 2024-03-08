module NotificationsHelper
  def render_notification(notification)
    actor = notification.actor
    case notification.action
    when 'commented'
      "#{actor.uname} commented on your post."
    when 'followed'
      "#{actor.uname} followed you."
    # Add more cases as needed for other notification types
    else
      "You have a new notification."
    end
  end
end
