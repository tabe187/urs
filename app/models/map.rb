class Map < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  def get_map_image(width, height)
      map_image.variant(resize_to_limit: [width, height]).processed
  end
end
