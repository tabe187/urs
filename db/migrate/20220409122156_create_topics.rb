class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.integer :community_id
      t.integer :user_id
      t.string :title
      t.text :explanation
      t.timestamps
    end
  end
end
