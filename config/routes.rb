# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  root 'application#homepage'
  namespace :images do
    resources :jobs, only: :create
  end
  resources :images, only: :index, concerns: :paginatable do
    member do
      get :show, path: '', as: :show
      put :clear
    end
  end
  mount Sidekiq::Web => '/sidekiq', as: :sidekiq
end
