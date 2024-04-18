# app/services/twitch_service.rb
require 'twitch'

class TwitchService
  def initialize(client_id)
    end
  end

  def user_is_live?(user_login)
    response = Twitch.streams.get_streams(user_login: user_login)
    response.data.any?
  rescue Twitch::Error::NotFound
    false
  end

  def get_current_game_title(user_login)
    response = Twitch.streams.get_streams(user_login: user_login)
    return unless response.data.any?

    response.data.first.game_name
  end
end
