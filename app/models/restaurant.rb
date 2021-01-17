# hotpepperAPIで取得した情報からインスタンスを作成する
# API側の仕様情報はHotpepperApi側に依存させる
class Restaurant
    attr_accessor :id, :name, :hotpepper_url, :img_url, :is_favorited
    def initialize(params)
        ini_params = HotpepperApi.initialize_restaurant_value(params)
        @id            = ini_params[:id]
        @name          = ini_params[:name]
        @hotpepper_url = ini_params[:hotpepper_url]  
        @img_url       = ini_params[:img_url]
        @is_favorited  = ini_params[:is_favorited]
    end
    
    def self.search_name(name, user)
        restaurants = HotpepperApi.search_at_name(name)
        rtn = []
        restaurants.each do |rs|
            rs_instance = Restaurant.new(rs)
            rs_instance.is_favorited = user.favoriting_restaurant?(rs_instance)
            rtn.push(rs_instance)
        end
        rtn
    end
    def self.search_at_id(id)
        Restaurant.new(HotpepperApi.serach_at_id(id))
    end
    def self.search_at_ids(ids)
        return [] if ids.length == 0
        restaurants = []
        HotpepperApi.serach_at_ids(ids).each do |rs|
            restaurants.push(Restaurant.new(rs))
        end
        return restaurants
    end

end
