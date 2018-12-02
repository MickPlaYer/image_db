# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  root 'application#homepage'
  resources :images, only: :index
  mount Sidekiq::Web => '/sidekiq'
end
