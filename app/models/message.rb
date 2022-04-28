class Message < ApplicationRecord
  
  has_one_attached :message_image
  
  belongs_to :room
  belongs_to :user
  
  
  def get_message_image(width, height)
      message_image.variant(resize_to_limit: [width, height]).processed
  end

end
