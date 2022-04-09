class CreateCommunities < ActiveRecord::Migration[6.1]
  def change
    create_table :communities do |t|
      t.integer :category_id
      t.integer :user_id
      t.string :title
      t.text :explanation
      
      t.timestamps
    end
  end
end
