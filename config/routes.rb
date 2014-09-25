require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  resources :items, except: [:index]
  resources :carts, only: [:index]

  root to: "static_pages#home"

  # authenticate :user, lambda { |u| u.admin? } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
end
