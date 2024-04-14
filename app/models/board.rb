class Board < ApplicationRecord

  has_many :messages, dependent: :destroy
  has_many :board_memberships, dependent: :destroy
  has_many :users, through: :board_memberships
  has_one_attached :avatar
  belongs_to :category, optional: true
end
