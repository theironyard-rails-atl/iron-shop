Rails.application.routes.draw do
  devise_for :users

  resources :items, except: [:index]
  resources :carts, only: [:index]

  resources :invoices, only: [:show] do
    member do
      post :close
    end
  end

  root to: "static_pages#home"

end
