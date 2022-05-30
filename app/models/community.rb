class Community < ApplicationRecord
  has_one_attached :community_image
  belongs_to :category
  belongs_to :user
  has_many :topics, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, uniqueness: true, presence: true
  validates :explanation, presence: true, length: { maximum: 1000 }

  def get_community_image(width, height)
    community_image.variant(resize_to_limit: [width, height]).processed
  end

  def participated_by?(user)
    participants.where(user_id: user.id).exists?
  end

  # どこで使っているか要確認
  def find_participant(user)
    participants.find_by(user_id: user.id)
  end

  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and community_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        community_id: id,
        visited_id: user_id,
        action: 'like'
      )

      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
