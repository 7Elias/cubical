class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :list_name
      t.string :property_type
      t.string :room_type
      t.string :city
      t.string :location
      t.integer :capacity
      t.integer :user_id
      t.timestamps
    end
  end
end
