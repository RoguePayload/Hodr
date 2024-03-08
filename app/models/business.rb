class Business < ApplicationRecord

  has_many :posts, as: :postable
  has_one_attached :avatar
  has_one_attached :banner
  has_secure_password
  has_many :products, dependent: :destroy
  has_many :jobs, dependent: :destroy

  # Scope to get users who have logged in within the last 30 days
  scope :active, -> { where('last_login_at > ?', 30.days.ago) }

  # Scope to get users who haven't logged in within the last 30 days
  scope :inactive, -> { where('last_login_at <= ? OR last_login_at IS NULL', 30.days.ago) }

  def self.activity_split
    active_cutoff = 30.days.ago
    active_businesses = Business.where("last_login_at > ?", active_cutoff).count
    inactive_businesses = Business.count - active_businesses
    [active_businesses, inactive_businesses]
  end
end
