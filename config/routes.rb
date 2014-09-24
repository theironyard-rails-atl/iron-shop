require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  root to: "static_pages#home"


  authenticate :user, -> { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
