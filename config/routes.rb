# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  root 'application#homepage'
  namespace :images do
    resources :jobs, only: :create
  end
  resources :images, only: :index do
    member do
      get :show, path: '', as: :show
      put :clear
    end
  end
  mount Sidekiq::Web => '/sidekiq', as: :sidekiq
end
