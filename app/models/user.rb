class User < ApplicationRecord

  after_create :assign_badge_based_on_id

  has_many :microposts, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :notifications, dependent: :destroy 

  has_one_attached :avatar

  has_one_attached :banner

  has_many :user_badges

  has_many :badges, through: :user_badges

  has_many :mentions
  has_many :mentioned_in_posts, through: :mentions, source: :micropost

  has_many :board_memberships
  has_many :boards, through: :board_memberships

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

  # Call this method after creating or updating microposts
  def assign_post_badges
    assign_youngling_badge
    assign_padawan_badge
    # Add more methods for other badges as needed
  end

  def assign_all_badges
    assign_badge_based_on_id
    assign_post_badges
  end

  # New custom validation method
  def email_excludes_forbidden_words
    forbidden_words = ["hodr", "hodr.me", "hodr.com", "hodr.net", "hodr.xyz", "hodr.org", "hodr.online", "hodr.site"]
    if forbidden_words.any? { |word| email.include?(word) }
      errors.add(:email, "contains a forbidden word or domain")
    end
  end

  private

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[#?!@$%^&*-])/

    errors.add :password, 'Complexity requirement not met. Length should be 6-20 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

  def assign_badge_based_on_id
    assign_hundred_badge if id <= 100
    assign_thousand_badge if id > 100 && id <= 1000
  end

  def assign_hundred_badge
    return unless id <= 100
    badge = Badge.find_by(name: 'First 100')
    UserBadge.find_or_create_by(user: self, badge: badge) if badge
  end

  def assign_thousand_badge
    return unless id > 100 && id <= 1000
    badge = Badge.find_by(name: 'First 1K')
    UserBadge.find_or_create_by(user: self, badge: badge) if badge
  end

  def assign_youngling_badge
    if microposts.count >= 1 && microposts.count <= 100
      badge = Badge.find_by(name: 'Youngling')
      UserBadge.find_or_create_by(user: self, badge: badge) if badge
    end
  end

  def assign_padawan_badge
    if microposts.count > 101 && microposts.count <= 200
      badge = Badge.find_by(name: 'Padawan')
      UserBadge.find_or_create_by(user: self, badge: badge) if badge
    end
  end
end
