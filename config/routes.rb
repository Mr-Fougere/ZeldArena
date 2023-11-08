# frozen_string_literal: true
Rails.application.routes.draw do
  root 'pages#home'
  resources :characters
  resources :equipments
  resources :battles
end
