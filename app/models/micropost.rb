class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :business, optional: true
  has_many :comments, dependent: :destroy
  has_many_attached :images do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 4 }
  validates :images, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif', 'image/webp'],
                       size: { less_than: 5.gigabytes , message: 'should be less than 5GB' }
  after_save :assign_user_post_badges
  private

  def assign_user_post_badges
    user.assign_post_badges
  end
end
