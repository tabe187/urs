class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      
      t.text :content
      t.references :user, type: :bigint, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.timestamps
    end
  end
end
