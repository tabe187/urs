class CreateMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :maps do |t|
      
      t.integer :user_id
      t.string :place_name
      t.string :address
      t.decimal :rating
      t.integer :telephone_number
      t.decimal :latitude, precision: 12, scale: 7
      t.decimal :longitude, precision: 12, scale: 7
      t.text :map_image
      t.text :website
      t.string :place_id
      t.integer :types, default: 0
      t.timestamps
    end
  end
end