class Board < ApplicationRecord
  scope :priority_order, -> { order(name: :asc) }
  has_many :messages, dependent: :destroy
  has_many :board_memberships, dependent: :destroy
  has_many :users, through: :board_memberships
  has_one_attached :avatar
end
