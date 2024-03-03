module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Hodr"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def auto_link_user_mentions(text)
    text.gsub(/@\w+/) do |mention|
      uname = mention[1..] # Removes the '@' character
      user = User.find_by(uname: uname)
      if user
        # Creates a link to the user's profile.
        link_to mention, user_path(user)
      else
        # If user not found, just return the mention text without a link.
        mention
      end
    end.html_safe
  end

end
