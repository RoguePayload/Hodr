class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  has_many_attached :images
end
