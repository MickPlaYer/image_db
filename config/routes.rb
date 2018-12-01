# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  root 'application#index'
  resources :images, only: :index
  mount Sidekiq::Web => '/sidekiq'
end
