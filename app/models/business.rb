class Business < ApplicationRecord

  has_many :posts, as: :postable
  has_one_attached :avatar
  has_one_attached :banner 
  has_secure_password

end
