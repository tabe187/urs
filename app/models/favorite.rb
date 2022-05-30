class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :map, counter_cache: :favorites_count

  validates_uniqueness_of :map_id, scope: :user_id
end
