class AddReviewsCountToMaps < ActiveRecord::Migration[6.1]
  def change
    add_column :maps, :reviews_count, :integer, null: false, default: 0
  end
end
