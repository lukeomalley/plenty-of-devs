# frozen_string_literal: true

Rails.application.routes.draw do
  resources :projects, only: [:new, :create, :show, :index]
  resources :skills, only: [:new, :create, :show]
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'matches#index'

  post '/like-user/:liked_user', to: 'matches#liked', as: 'like_user'
  post '/dislike-user/:disliked_user', to: 'matches#disliked', as: 'dislike_user'
end
