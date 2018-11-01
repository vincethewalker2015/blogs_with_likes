class Like < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  
  validates_uniqueness_of :user, scope: :topic
end