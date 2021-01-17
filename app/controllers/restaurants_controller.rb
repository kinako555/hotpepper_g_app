class RestaurantsController < ApplicationController
    before_action :authenticate_user!
    def index
        res_data = Restaurant.search_name(params['name'], current_user)
        render :json => res_data
    end
end
