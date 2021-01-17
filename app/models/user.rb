# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  def favorite_restaurant_relations
    FavoriteRestaurant.where(user_id: self.id)
  end

  def favorite_restaurant(restaurant)
    FavoriteRestaurant.create!(user_id: self.id, restaurant_id: restaurant.id)
  end
  # 投稿のファボを解除する
  def unfavorite_restaurant(restaurant)
    FavoriteRestaurant.find_by!(user_id: self.id, restaurant_id: restaurant.id).destroy
  end
  # 投稿をファボしていたらtrueを返す
  def favoriting_restaurant?(restaurant)
    favorite_restaurant_relations.each do |reration|
      return true if reration.restaurant_id == restaurant.id
    end
    return false
  end

  def favoriting_restaurants
    restaurants = Restaurant.search_at_ids(favoriting_restaurant_ids)
    rtn_restaurants = []
    restaurants.each do |rs|
      rs.is_favorited = true
      rtn_restaurants.push(rs)
    end
    rtn_restaurants
  end

  private
    def favoriting_restaurant_ids
      rtn_ids = []
      favorite_restaurant_relations.each do |relation|
        rtn_ids.push(relation['restaurant_id'])
      end
      rtn_ids
    end
end
