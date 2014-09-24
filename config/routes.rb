require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  root to: "static_pages#home"

  resources :invoices, only: [:show] do
    member do
      post :close
    end
  end

  # This is a Sinatra app
  # This should be secured using a Devise construct like -v
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
end
