# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  root 'application#homepage'
  resources :images, only: :index do
    collection do
      post :query_all
    end
    member do
      get :show, path: '', as: :show
      put :clear
    end
  end
  mount Sidekiq::Web => '/sidekiq', as: :sidekiq
end
