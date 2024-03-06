class Micropost < ApplicationRecord
  after_save :create_mentions
  belongs_to :user
  belongs_to :business, optional: true
  has_many :comments, dependent: :destroy
  has_many :mentions
  has_many :mentioned_users, through: :mentions, source: :user
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


  def create_mentions
    # Extracting mentions by uname
    mentioned_unames = content.scan(/@(\w+)/).flatten
    mentioned_unames.each do |uname|
      user = User.find_by(uname: uname)
      mentions.create(user: user) if user
    end
  end  
end
