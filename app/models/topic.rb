class Topic < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  belongs_to :user
  validates :user_id, presence: true
  has_many :comments, dependent: :destroy
  
  mount_uploader :picture, PictureUploader
  
  # Validates the size of and Uploaded image
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "Image file size should be less than 5MB")
    end
  end
  
end