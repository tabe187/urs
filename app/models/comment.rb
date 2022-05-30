class Comment < ApplicationRecord
  has_one_attached :comment_image
  belongs_to :user
  belongs_to :topic

  validates :comment, presence: true, length: { maximum: 1000 }

  def get_comment_image(width, height)
    comment_image.variant(resize_to_limit: [width, height]).processed
  end
end
