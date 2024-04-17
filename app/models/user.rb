class User < ApplicationRecord

  after_create :assign_badges_based_on_id

  has_one :subscription

  attr_accessor :remove_background_music

  validates :twitch_profile_name, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "Only alphanumeric characters and underscores allowed" }, allow_blank: true

  before_validation :remove_background_music_if_requested

  has_many :microposts, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :chat_chambers

  has_many :chat_messages

  has_many :notifications, dependent: :destroy

  has_one_attached :avatar

  has_one_attached :background_music

  has_one_attached :banner

  has_one_attached :background_image

  has_many :user_badges

  has_many :badges, through: :user_badges

  has_many :mentions
  has_many :mentioned_in_posts, through: :mentions, source: :micropost

  has_many :active_relationships, class_name:   "Relationship",
                                  foreign_key:  "follower_id",
                                  dependent:    :destroy

  has_many :passive_relationships,  class_name:   "Relationship",
                                    foreign_key:  "followed_id",
                                    dependent:    :destroy

  has_many :following, through: :active_relationships, source: :followed

  has_many :followers, through: :passive_relationships, source: :follower

  attr_accessor :remember_token

  before_save { email.downcase! }

  validates :uname, presence: true, length: { maximum: 50 }, allow_nil: true

  validates :uname, format: { without: /\s/, message: "must not contain spaces" }

  validates :fname, length: { maximum: 50 }, allow_nil: true

  validates :mname, length: { maximum: 50 }, allow_nil: true

  validates :lname, length: { maximum: 50 }, allow_nil: true

  validates :tel, length: { maximum: 20 }, allow_nil: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  validate :email_excludes_forbidden_words

  validates :adr1, length: { maximum: 50 }, allow_nil: true

  validates :adr2, length: { maximum: 50 }, allow_nil: true

  validates :city, length: { maximum: 50 }, allow_nil: true

  validates :state, length: { maximum: 50 }, allow_nil: true

  validates :zip, length: { maximum: 20 }, allow_nil: true

  validates :country, length: { maximum: 50 }, allow_nil: true

  validates :git, length: { maximum: 90 }, allow_nil: true

  validates :twitter, length: { maximum: 90 }, allow_nil: true

  validates :lin, length: { maximum: 90 }, allow_nil: true

  validates :web, length: { maximum: 90 }, allow_nil: true

  validates :ytube, length: { maximum: 90 }, allow_nil: true

  validates :degree, length: { maximum: 90 }, allow_nil: true

  validates :sname, length: { maximum: 90 }, allow_nil: true

  validates :cstudies, length: { maximum: 1500 }, allow_nil: true

  validates :marital, length: { maximum: 20 }, allow_nil: true

  validates :spouse, length: { maximum: 30 }, allow_nil: true

  validates :kids, length: { maximum: 90 }, allow_nil: true

  validates :books, length: { maximum: 1500 }, allow_nil: true

  validates :movies, length: { maximum: 1500 }, allow_nil: true

  validates :activity, length: { maximum: 1500 }, allow_nil: true

  validates :songs, length: { maximum: 1500 }, allow_nil: true

  validates :games, length: { maximum: 1500 }, allow_nil: true

  validates :jtitle, length: { maximum: 90 }, allow_nil: true

  validates :cname, length: { maximum: 90 }, allow_nil: true

  validates :ljob, length: { maximum: 90 }, allow_nil: true

  validates :jdesc, length: { maximum: 2500 }, allow_nil: true

  validates :bio, length: { maximum: 3500 }, allow_nil: true

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  validate :password_complexity

  scope :top_contributors, -> (limit: 5) {
    joins(:microposts).group(:id).order('COUNT(microposts.id) DESC').limit(limit)
  }

  # Scope to get users who have logged in within the last 30 days
  scope :active, -> { where('last_login_at > ?', 30.days.ago) }

  # Scope to get users who haven't logged in within the last 30 days
  scope :inactive, -> { where('last_login_at <= ? OR last_login_at IS NULL', 30.days.ago) }

  def self.activity_split
    active_cutoff = 30.days.ago
    active_users = User.where("last_login_at > ?", active_cutoff).count
    inactive_users = User.count - active_users
    [active_users, inactive_users]
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # Returns a session token to prevent session hijacking.
  # We reuse the remember digest for convenience.
  def session_token
    remember_digest || remember
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns a user's status feed.
  def feed
     following_ids = "SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id"
     Micropost.where("user_id IN (#{following_ids})
                      OR user_id = :user_id", user_id: id)
              .includes(:user, images_attachments: :blob)
  end

  # Follows a user.
  def follow(other_user)
     following << other_user unless self == other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
     following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
     following.include?(other_user)
  end

  def assign_all_badges
    assign_admin_and_premium_badges if admin? && is_premium?
    assign_badges
  end

  def has_premium_access?
    is_premium || admin?
  end

  # New custom validation method
  def email_excludes_forbidden_words
    forbidden_words = ["hodr", "hodr.me", "hodr.com", "hodr.net", "hodr.xyz", "hodr.org", "hodr.online", "hodr.site"]
    if forbidden_words.any? { |word| email.include?(word) }
      errors.add(:email, "contains a forbidden word or domain")
    end
  end

  def subscribed?
    subscription.present? && subscription.status == 'active'
  end

  def has_premium_access?
    subscription.present? && (subscription.canceled_at.nil? || subscription.canceled_at > Time.current)
  end

  private

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[#?!@$%^&*-])/

    errors.add :password, 'Complexity requirement not met. Length should be 6-20 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

  def remove_background_music_if_requested
    self.background_music.purge if remove_background_music == "1"
  end

  def assign_admin_and_premium_badges
    # Logic to assign badges for users who are both admins and premium users
    assign_admin_badge
    assign_premium_badge
  end

  def assign_admin_badge
    admin_badge = Badge.find_by(name: 'Admin Badge')
    UserBadge.find_or_create_by(user: self, badge: admin_badge) if admin_badge
  end

  def assign_premium_badge
    premium_badge = Badge.find_by(name: 'Premium Badge')
    UserBadge.find_or_create_by(user: self, badge: premium_badge) if premium_badge
  end

  def assign_badges
    assign_first_100_users_badge if id <= 100
    assign_first_1k_users_badge if id > 100 && id <= 1000
    assign_content_maker_badge if microposts.count.between?(1, 100)
    assign_my_page_creator_badge if microposts.count.between?(101, 200)
    assign_my_page_influencer_badge if microposts.count.between?(201, 300)
    assign_my_page_post_creator_badge if microposts.count.between?(301, 400)
    assign_my_page_heavy_influencer_badge if microposts.count.between?(401, 500)
    assign_my_page_post_master_badge if microposts.count.between?(501, 1000)
    assign_my_page_content_master_badge if microposts.count > 1000
  end

  def assign_badges_based_on_id
    if id <= 100
      assign_first_100_users_badge
    elsif id <= 1000 && id >= 101
      assign_first_1000_users_badge
    end
  end

  def assign_first_100_users_badge
    badge = Badge.find_by(name: 'First 100 Registered Users')
    if badge
      UserBadge.find_or_create_by(user: self, badge: badge)
    end
  end

  def assign_first_1000_users_badge
    badge = Badge.find_by(name: 'First 1000 Registered Users')
    if badge
      UserBadge.find_or_create_by(user: self, badge: badge)
    end
  end


  def assign_content_maker_badge
    badge = Badge.find_by(name: 'Content Maker')
    if badge && microposts.count.between?(1, 100)
      UserBadge.find_or_create_by(user: self, badge: badge)
    end
  end

  def assign_content_maker_badge
    badge = Badge.find_by(name: 'Content Maker')
    UserBadge.find_or_create_by(user: self, badge: badge) if badge
  end

  def assign_my_page_creator_badge
    badge = Badge.find_by(name: 'MyPage Creator')
    UserBadge.find_or_create_by(user: self, badge: badge) if badge
  end

  def assign_my_page_influencer_badge
    badge = Badge.find_by(name: 'MyPage Influencer')
    UserBadge.find_or_create_by(user: self, badge: badge) if badge
  end

  def assign_my_page_post_creator_badge
    badge = Badge.find_by(name: 'MyPage Post Creator')
    UserBadge.find_or_create_by(user: self, badge: badge) if badge
  end

  def assign_my_page_heavy_influencer_badge
    badge = Badge.find_by(name: 'MyPage Heavy Influencer')
    UserBadge.find_or_create_by(user: self, badge: badge) if badge
  end

  def assign_my_page_post_master_badge
    badge = Badge.find_by(name: 'MyPage Post Master')
    UserBadge.find_or_create_by(user: self, badge: badge) if badge
  end

  def assign_my_page_content_master_badge
    badge = Badge.find_by(name: 'MyPage Content Master')
    UserBadge.find_or_create_by(user: self, badge: badge) if badge
  end
end
