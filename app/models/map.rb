class Map < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  def get_map_image(width, height)
      map_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  enum types: { restaurant: 0, park: 1, bar: 2, night_club: 3, clothing_store: 4, cafe: 5, hotel: 6, hot_spring: 7, other: 8 }
  
  # scope :latest, -> {order(updated_at: :desc)}
  # scope :old, -> {order(updated_at: :asc)}
  # scope :favorite_count, -> { includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}}
  
  
end
