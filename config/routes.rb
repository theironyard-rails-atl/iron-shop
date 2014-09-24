require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  resources :items, except: [:index]


  root to: "static_pages#home"


  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
end
