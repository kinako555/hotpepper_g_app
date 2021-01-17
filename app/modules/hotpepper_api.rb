require 'json'
require 'net/https'
require 'uri'
# hotpepperAPIを使用して飲食店情報を取得するModule

module HotpepperApi
    DEFAULT_URI = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?"
    KEY = Rails.application.credentials.hotpepper[:key] # TODO: 隠しファイルに移動する
    # apiから取得した1つの飲食店情報から必要な値を抽出してハッシュに格納する
    def initialize_restaurant_value(params)
        rtn = {
            id:            params['id'],
            name:          params['name'],
            hotpepper_url: params['urls']['pc'],
            img_url:       params['photo']['pc']['m'],
            is_favorited:  false
        }
        return rtn
    end
    module_function :initialize_restaurant_value
    # search_wordを使い店名検索する
    def search_at_name(search_word)
        data = { key: KEY, name: search_word, type: "lite" }
        res_data = excute_query(data)
        return [] if not_found?(res_data)
        return res_data['results']['shop']
    end
    module_function :search_at_name
    # idを配列にするのとにより複数検索が可能
    # 単数で返す
    def serach_at_id(id)
        data = { key: KEY, id: id, type: "lite" }
        res_data = excute_query(data)
        return [] if not_found?(res_data)
        return res_data['results']['shop']
    end
    module_function :serach_at_id

    # idを配列にするのとにより複数検索が可能
    # 配列で返す
    def serach_at_ids(ids)
        data = { key: KEY, id: ids.join(','), type: "lite" }
        res_data = excute_query(data)
        return [] if not_found?(res_data)
        # 1件しか取得できなかった場合は
        # res_data['results']['shop']が配列でないので、配列に変換する
        if res_data['results']['shop'].class.name != Array.name
            rtn = []
            rtn.push(res_data['results']['shop'])
            return rtn
        end
        return res_data['results']['shop']
    end
    module_function :serach_at_ids
    
    def self.excute_query(data)
        query = data.to_query
        uri = URI(DEFAULT_URI+query)
        http = Net::HTTP.new(uri.host, uri.port)
        # http.use_ssl = true httpsで通信する際はコメントを外す
        req = Net::HTTP::Get.new(uri)
        res = http.request(req)
        res_data = Hash.from_xml(res.body)
        return res_data
    end
    # 検索結果が0件ならtrue
    def self.not_found?(res_data)
        res_data['results']['results_returned'].to_i == 0
    end
    
end
