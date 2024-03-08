module NotificationsHelper
  def render_notification(notification)
    actor = notification.actor
    case notification.action
    when 'commented'
      comment_text = notification.notifiable.content.truncate(50) # Truncate to avoid overly long texts
      "#{actor.uname} commented on your post: \"#{comment_text}\""
    when 'followed'
      "#{actor.uname} followed you."
    # Add more cases as needed for other notification types
    else
      "You have a new notification."
    end
  end
end
