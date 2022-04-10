class Community < ApplicationRecord
  has_one_attached :community_image
  belongs_to :category
  belongs_to :user
  has_many :topics, dependent: :destroy
  has_many :participants, dependent: :destroy
  def get_community_image(width, height)
      community_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def participated_by?(user)
    participants.where(user_id: user.id).exists?
  end
  
end
