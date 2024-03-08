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
  has_one_attached :video
  validates :video, content_type: ['video/mp4', 'video/mov', 'video/avi', 'video/mpeg', 'video/quicktime', 'video/webm', 'video/x-ms-wmv'], size: { less_than: 10.gigabytes , message: 'should be less than 10GB' }
  validate :validate_video_length
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 4 }
  validates :images, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif', 'image/webp', 'video/mp4', 'video/mov', 'video/webm'],
                       size: { less_than: 5.gigabytes , message: 'should be less than 5GB' }
  after_save :assign_user_post_badges
  after_commit :fetch_link_preview, on: :create

  def fetch_link_preview
    # Simple regex to find URLs in the content
    url = content.match(URI.regexp)
    return unless url

    # Use LinkThumbnailer to fetch URL info
    preview = LinkThumbnailer.generate(url[0])
    # Store or process preview data as needed
  end

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

  def validate_video_length
    if video.attached? && !video_length_valid?
      errors.add(:video, "should be less than 60 seconds")
    end
  end

  def video_length_valid?
    # Dummy implementation: You need to implement video length validation.
    # This might involve using a service like FFmpeg or ActiveStorage Analyzer to get the video duration.
    true
  end

end
