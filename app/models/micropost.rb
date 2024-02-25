class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 4 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                     message: "must be a valid image format" },
                    size:         { less_than: 5.gigabytes,
                                     message:   "should be less than 5GB" }
end
