class Community < ApplicationRecord
  has_one_attached :community_image
  belongs_to :category
  
  def get_community_image(width, height)
      community_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
