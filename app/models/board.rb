# app/models/board.rb
class Board < ApplicationRecord
  # Associations
  has_many :messages, dependent: :destroy
  has_many :board_memberships, dependent: :destroy
  has_many :users, through: :board_memberships
  has_one_attached :avatar
  belongs_to :category, optional: true
  belongs_to :user

  # Validations
  validates :name, presence: true
  validates :invite_link, presence: true, uniqueness: true

  # Methods
  def password_protected?
    !password_digest.blank?
  end
end
