Rails.application.routes.draw do
  devise_for :users

  resources :items, except: [:index]


  root to: "static_pages#home"
end
