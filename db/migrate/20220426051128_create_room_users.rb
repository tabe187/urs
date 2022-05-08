class CreateRoomUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :room_users do |t|
      t.references :user, type: :bigint, foreign_key: true
      t.references :room, foreign_key: true
      t.timestamps
    end
  end
end
