Rails.application.routes.draw do
  devise_for :users

  root to: "static_pages#home"

  scope '/cart' do
    get "/" => "carts#show_cart", :as => "cart"
    get "/data" => "carts#data"
    post "/add-cart/:id" => "carts#add_cart"
    delete "/remove-cart/:id" => "carts#remove_cart"
  end
end
