Rails.application.routes.draw do



  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :items, except: [:index]



  get '/cart', to: 'carts#show'
  get '/cart/add', to: 'carts#add'
  get '/cart/remove', to: 'carts#remove'

  root to: "static_pages#home"

end
