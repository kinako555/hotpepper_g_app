class CreateFavoriteRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_restaurants do |t|
      t.integer :user_id, :null => false
      t.string :restaurant_id, :null => false
      t.timestamps
    end
    add_index :favorite_restaurants, :user_id
    add_index :favorite_restaurants, [:user_id, :restaurant_id], unique: true
  end
end
