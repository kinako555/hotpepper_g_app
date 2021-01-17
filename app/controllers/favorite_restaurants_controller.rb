class FavoriteRestaurantsController < ApplicationController
    before_action :authenticate_user!
    def index
        render :json => current_user.favoriting_restaurants
    end
    def create
        restaurant = HotpepperApi.serach_at_id(params[:id])
        if !restaurant.length == 0
            p "エラーだよ"
        end
        current_user.favorite_restaurant(Restaurant.new(restaurant))
        render :json => {success: 200}
    end
    def destroy
        restaurant = HotpepperApi.serach_at_id(params[:id])
        if !restaurant.length == 0
            p "エラーだよ"
        end
        current_user.unfavorite_restaurant(Restaurant.new(restaurant))
        render :json => {success: 200}
    end
end