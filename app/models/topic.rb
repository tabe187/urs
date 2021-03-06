class Topic < ApplicationRecord
  has_one_attached :topic_image
  belongs_to :community
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :explanation, presence: true, length: { maximum: 1000 }

  def get_topic_image(width, height)
    topic_image.variant(resize_to_limit: [width, height]).processed
  end
end
