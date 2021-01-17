class FavoriteRestaurant < ApplicationRecord
    belongs_to :user,       class_name: User.name
    validates :user_id,       presence: true
    validates :restaurant_id, presence: true
end
