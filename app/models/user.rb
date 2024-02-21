class User < ApplicationRecord

  attr_accessor :remember_token

  before_save { email.downcase! }

  validates :uname, presence: true, length: { maximum: 50 }, allow_nil: true

  validates :fname, presence: true, length: { maximum: 50 }, allow_nil: true

  validates :mname, presence: true, length: { maximum: 50 }, allow_nil: true

  validates :lname, presence: true, length: { maximum: 50 }, allow_nil: true

  validates :tel, presence: true, length: { maximum: 20 }, allow_nil: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  validates :adr1, presence: true, length: { maximum: 50 }, allow_nil: true

  validates :adr2, presence: true, length: { maximum: 50 }, allow_nil: true

  validates :city, presence: true, length: { maximum: 50 }, allow_nil: true

  validates :state, presence: true, length: { maximum: 50 }, allow_nil: true

  validates :zip, presence: true, length: { maximum: 20 }, allow_nil: true

  validates :country, presence: true, length: { maximum: 50 }, allow_nil: true

  validates :git, presence: true, length: { maximum: 90 }, allow_nil: true

  validates :twitter, presence: true, length: { maximum: 90 }, allow_nil: true

  validates :lin, presence: true, length: { maximum: 90 }, allow_nil: true

  validates :web, presence: true, length: { maximum: 90 }, allow_nil: true

  validates :ytube, presence: true, length: { maximum: 90 }, allow_nil: true

  validates :degree, presence: true, length: { maximum: 90 }, allow_nil: true

  validates :sname, presence: true, length: { maximum: 90 }, allow_nil: true

  validates :marital, presence: true, length: { maximum: 20 }, allow_nil: true

  validates :spouse, presence: true, length: { maximum: 30 }, allow_nil: true

  validates :kids, presence: true, length: { maximum: 90 }, allow_nil: true

  validates :books, presence: true, length: { maximum: 1500 }, allow_nil: true

  validates :movies, presence: true, length: { maximum: 1500 }, allow_nil: true

  validates :activity, presence: true, length: { maximum: 1500 }, allow_nil: true

  validates :songs, presence: true, length: { maximum: 1500 }, allow_nil: true

  validates :games, presence: true, length: { maximum: 1500 }, allow_nil: true

  validates :jtitle, presence: true, length: { maximum: 90 }, allow_nil: true

  validates :cname, presence: true, length: { maximum: 90 }, allow_nil: true

  validates :ljob, presence: true, length: { maximum: 90 }, allow_nil: true

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }

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

end
