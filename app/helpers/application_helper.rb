module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "MyPage"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def format_content_with_mentions(content)
    linked_content = content.gsub(/@(\w+)/) do |match|
      user = User.find_by(uname: $1)
      if user
        link_to match, user_path(user)
      else
        match
      end
    end
    simple_format(linked_content).html_safe
  end

end
