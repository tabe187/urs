class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.integer :community_id
      t.integer :user_id
      t.timestamps
    end
  end
end
