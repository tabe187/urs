class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :map_id
      t.integer :user_id
      t.text :review
      t.timestamps
    end
  end
end
