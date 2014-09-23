Rails.application.routes.draw do
  devise_for :users

  root to: "static_pages#home"

  resources :invoices, only: [:show] do 
    member do 
     post :close
    end
  end
end
