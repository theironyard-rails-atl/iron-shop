Rails.application.routes.draw do
  devise_for :users

  root to: "static_pages#home"

  resources :invoices, only: [:show] do
    member do
      post :close
    end
  end

  resources :items do
    member do
      post :watch, to: 'watched_items#create'
    end
    collection do 
      get :my_items
    end
  end

  resources :watched_items, only: [:index, :create, :destroy, :show]
  get '/cart' => 'invoices#show_cart'
  post '/cart' => 'invoices#add_to_cart'

  get '*path' => 'static_pages#home'
end
