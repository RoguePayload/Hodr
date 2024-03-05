class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :business, optional: true
  has_many :comments, dependent: :destroy
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 4 }
  validates :image, content_type: { in: ['image/jpeg', 'image/gif', 'image/png', 'image/webp', 'application/pdf', 'video/mp4', 'audio/mpeg', 'text/plain', 'application/msword', 'application/vnd.ms-excel', 'application/vnd.ms-powerpoint', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'application/vnd.openxmlformats-officedocument.presentationml.presentation'],
                                    message: "is not a supported format" },
                     size:         { less_than: 15.gigabytes,
                                     message:   "should be less than 15GB" }
  after_save :assign_user_post_badges
  private

  def assign_user_post_badges
    user.assign_post_badges
  end
end
