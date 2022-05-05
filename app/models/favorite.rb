class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :map, counter_cache: :favorites_count
end
