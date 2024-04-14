class ChatMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat_chamber
end
