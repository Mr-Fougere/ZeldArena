# frozen_string_literal: true
Rails.application.routes.draw do
  root 'pages#home'
  resources :characters
  resources :equipments
  resources :battles

  post 'arena/update_ui', to: 'battles#update_ui'
  post 'next_tutorial_page', to: 'pages#next_tutorial_page', as: 'next_tutorial_page'
end
