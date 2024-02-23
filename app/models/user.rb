class User < ApplicationRecord

  has_many :microposts, dependent: :destroy

  attr_accessor :remember_token

  before_save { email.downcase! }

  validates :uname, presence: true, length: { maximum: 50 }, allow_nil: true

  validates :fname, length: { maximum: 50 }, allow_nil: true

  validates :mname, length: { maximum: 50 }, allow_nil: true

  validates :lname, length: { maximum: 50 }, allow_nil: true

  validates :tel, length: { maximum: 20 }, allow_nil: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

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

  # Defines a proto-feed.
  # See "Following users" for the full implementation.
  def feed
     Micropost.where("user_id = ?", id)
  end  

end
