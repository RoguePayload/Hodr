# app/models/board_membership.rb
class BoardMembership < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :board

  # Validations
  validates :user_id, uniqueness: { scope: :board_id }
end
