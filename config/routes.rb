Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/restaurants', to: 'restaurants#index'
  get    '/favorite_restaurants' , to: 'favorite_restaurants#index'
  post   '/restaurant_favorite'  , to: 'favorite_restaurants#create'
  delete '/restaurant_favorite'  , to: 'favorite_restaurants#destroy'
end
