module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80)
    gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.uname, class: "gravatar")
  end

  def user_background_style(user)
    if user.background_image.attached?
      "background-image: url(#{url_for(user.background_image)}); background-size: cover; background-position: center center; background-color: transparent !important;"
    elsif user.background_color.present?
      "background-color: #{user.background_color} !important;"
    else
      "" # Default background or another CSS rule
    end
  end



  def all_colors
    [
      { name: "Red", value: "red" },
      { name: "Green", value: "green" },
      { name: "Blue", value: "blue" },
      { name: "Black", value: "black" },
      { name: "White", value: "white" },
      { name: "Yellow", value: "yellow" },
      { name: "Orange", value: "orange" },
      { name: "Purple", value: "purple" },
      { name: "Gray", value: "gray" }
      # Add more colors as needed
    ]
  end

end
