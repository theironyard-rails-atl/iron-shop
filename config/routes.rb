Rails.application.routes.draw do
  require 'sidekiq/web'

  devise_for :users
  root to: "items#index"

  mount Sidekiq::Web => '/sidekiq'

  resources :items, only: [:index, :new, :create, :update, :show]
  resources :watches, only: [:index, :create, :update, :destroy]

  scope '/cart' do
    get "/" => "carts#show_cart", :as => "cart"
    get "/data" => "carts#data"
    post "/add-cart/:id" => "carts#add_cart", :as => "add_cart"
    delete "/remove-cart/:id" => "carts#remove_cart"
  end

end
