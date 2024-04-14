module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80)
    gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.uname, class: "gravatar")
  end

  def user_background_style(user)
    if user.background_image.attached?
      "background-image: url(#{url_for(user.background_image)}); background-size: cover; background-attachment: fixed;"
    elsif user.background_color.present?
      "background-color: #{user.background_color};"
    else
      ""
    end
  end


  def google_fonts_for_selection(is_premium)
    all_fonts = [
      # Free Fonts
      { name: "Silkscreen", value: "Silkscreen", premium: false },
      { name: "Luckiest Guy", value: "Luckiest Guy", premium: false },
      { name: "Space Mono", value: "Space Mono", premium: false },
      { name: "Spectral", value: "Spectral", premium: false },
      { name: "Righteous", value: "Righteous", premium: false },
      { name: "Great Vibes", value: "Great Vibes", premium: false },
      { name: "Montserrat Alternates", value: "Montserrat Alternates", premium: false },
      # Premium Fonts
      { name: "Amatic SC", value: "Amatic SC", premium: true },
      { name: "Black Ops One", value: "Black Ops One", premium: true },
      { name: "Exo", value: "Exo", premium: true },
      { name: "Bungee Spice", value: "Bungee Spice", premium: true },
      { name: "Cinzel", value: "Cinzel", premium: true },
      { name: "Orbitron", value: "Orbitron", premium: true },
      { name: "Crimson Pro", value: "Crimson Pro", premium: true },
      { name: "Source Serif 4", value: "Source Serif 4", premium: true },
      { name: "Tilt Neon", value: "Tilt Neon", premium: true },
      { name: "IBM Plex Serif", value: "IBM Plex Serif", premium: true },
      { name: "Permanent Marker", value: "Permanent Marker", premium: true },
      { name: "Seymour One", value: "Seymour One", premium: true },
      { name: "Shadows Into Light", value: "Shadows Into Light", premium: true },
      { name: "Tac One", value: "Tac One", premium: true },
      { name: "Cormorant Garamond", value: "Cormorant Garamond", premium: true },
      { name: "Red Hat Display", value: "Red Hat Display", premium: true },
      { name: "Play", value: "Play", premium: true },
      { name: "Nanum Gothic Coding", value: "Nanum Gothic Coding", premium: true },
      { name: "Space Grotesk", value: "Space Grotesk", premium: true },
      { name: "Comfortaa", value: "Comfortaa", premium: true },
      { name: "Lobster", value: "Lobster", premium: true },
      { name: "Saira Condensed", value: "Saira Condensed", premium: true },
      { name: "Assistant", value: "Assistant", premium: true },
      { name: "Crimson Text", value: "Crimson Text", premium: true },
      { name: "Exo 2", value: "Exo 2", premium: true },
      { name: "Source Code Pro", value: "Source Code Pro", premium: true },
      { name: "Hind", value: "Hind", premium: true },
      { name: "Teko", value: "Teko", premium: true },
      { name: "Oxygen", value: "Oxygen", premium: true},
      { name: "Outfit", value: "Outfit", premium: true },
      { name: "Bitter", value: "Bitter", premium: true },
      { name: "EB Garamond", value: "EB Garamond", premium: true },
      { name: "Dancing Script", value: "Dancing Script", premium: true },
      { name: "Cabin", value: "Cabin", premium: true },
      { name: "Anton", value: "Anton", premium: true },
      { name: "Dosis", value: "Dosis", premium: true },
      { name: "Libre Baskerville", value: "Libre Baskerville", premium: true },
      { name: "Hind Siliguri", value: "Hind Siliguri", premium: true },
      { name: "Mukta", value: "Mukta", premium: true },
      { name: "Bebas Neue", value: "Bebas Neue", premium: true },
      { name: "Inconsolata", value: "Inconsolata", premium: true },
      { name: "Jersey 25", value: "Jersey 25", premium: true },
      { name: "Karla", value: "Karla", premium: true },
      { name: "Noto Serif", value: "Noto Serif", premium: true },
      { name: "Libre Franklin", value: "Libre Franklin", premium: true },
      { name: "Nanum Gothic", value: "Nanum Gothic", premium: true },
      { name: "PT Serif", value: "PT Serif", premium: true },
      { name: "Manrope", value: "Manrope", premium: true },
      { name: "Titillium Web", value: "Titillium Web", premium: true },
      { name: "IBM Plex Sans", value: "IBM Plex Sans", premium: true },
      { name: "Quicksand", value: "Quicksand", premium: true },
      { name: "Fira Sans", value: "Fira Sans", premium: true },
      { name: "Barlow", value: "Barlow", premium: true },
      { name: "Jersey 15", value: "Jersey 15", premium: true },
      { name: "Mulish", value: "Mulish", premium: true },
      { name: "DM Sans", value: "DM Sans", premium: true },
      { name: "Lora", value: "Lora", premium: true },
      { name: "Work Sans", value: "Work Sans", premium: true },
      { name: "PT Sans", value: "PT Sans", premium: true },
      { name: "Jersey 10", value: "Jersey 10", premium: true },
      { name: "Roboto Slab", value: "Roboto Slab", premium: true },
      { name: "Merriweather", value: "Merriweather", premium: true },
      { name: "Playfair Display", value: "Playfair Display", premium: true },
      { name: "Ubuntu", value: "Ubuntu", premium: true },
      { name: "Nunito", value: "Nunito", premium: true },
      { name: "Raleway", value: "Raleway", premium: true },
      { name: "Jersey 20", value: "Jersey 20", premium: true },
      { name: "Noto Sans", value: "Noto Sans", premium: true },
      { name: "Roboto Mono", value: "Roboto Mono", premium: true },
      { name: "Oswald", value: "Oswald", premium: true },
      { name: "Jacquard 24", value: "Jacquard 24", premium: true },
      { name: "Roboto Condensed", value: "Roboto Condensed", premium: true },
      { name: "Lato", value: "Lato", premium: true },
      { name: "Poppins", value: "Poppins", premium: true },
      { name: "Platypi", value: "Platypi", premium: true },
      { name: "Sedan", value: "Sedan", premium: true },
      { name: "Roboto", value: "Roboto", premium: true }
    ]
    # Generate options for select helper with disabled attribute based on premium status
    all_fonts.map do |font|
      [
        font[:name],
        font[:value],
        { disabled: font[:premium] && !is_premium }
      ]
    end
  end


  def user_color_options(user)
    basic_colors = [
      { name: "Red", value: "red" },
      { name: "Green", value: "green" },
      { name: "Blue", value: "blue" },
      { name: "White", value: "white" },
      { name: "Black", value: "black" }
    ]

    premium_colors = [
      { name: "Yellow", value: "yellow" },
      { name: "Orange", value: "orange" },
      { name: "Purple", value: "purple" },
      { name: "Gray", value: "gray" },
      { name: "Pink", value: "pink" },
      { name: "Teal", value: "teal" },
      { name: "Turquoise", value: "turquoise" },
      { name: "Magenta", value: "magenta" },
      { name: "Lime", value: "lime" },
      { name: "Coral", value: "coral" },
      { name: "Aqua", value: "aqua" },
      { name: "Maroon", value: "maroon" },
      { name: "Olive", value: "olive" },
      { name: "Navy", value: "navy" },
      { name: "Mint", value: "mint" },
      { name: "Gold", value: "gold" },
      { name: "Salmon", value: "salmon" },
      { name: "Ivory", value: "ivory" }
    ]

    # Add disabled property for premium colors if user is not premium
    if user.is_premium?
      color_options = basic_colors + premium_colors
    else
      color_options = basic_colors + premium_colors.map { |color| color.merge(disabled: 'disabled') }
    end

    options_for_select(color_options.map { |color| [color[:name], color[:value], {disabled: color[:disabled]}] }, user.background_color)
  end



end
