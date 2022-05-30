class Review < ApplicationRecord
  has_one_attached :review_image
  belongs_to :user
  belongs_to :map, counter_cache: :reviews_count

  def get_review_image(width, height)
    review_image.variant(resize_to_limit: [width, height]).processed
  end
end
