Rails.application.routes.draw do
  devise_for :users

  resources :user, only: [:show] do
    resources :carts, only: [:create, :update, :destroy]
  end

  resources :items
  resources :invoices


  root to: "static_pages#home"
end
