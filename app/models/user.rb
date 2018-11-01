class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  
  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_secure_password
  
  mount_uploader :picture, PictureUploader
  # Validates the size of and Uploaded image
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "Image file size should be less than 5MB")
    end
  end
end