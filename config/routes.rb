# frozen_string_literal: true

Rails.application.routes.draw do
  resources :projects, only: [:new, :create, :show, :index]
  resources :skills, only: [:new, :create, :show]
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'matches#index'
  resources :users, only: [:show]

  # routes for liking and disliking a user
  post '/like-user/:liked_user', to: 'matches#liked', as: 'like_user'
  post '/dislike-user/:disliked_user', to: 'matches#disliked', as: 'dislike_user'

  # user matches page
  get '/matches', to: 'users#matches', as: 'matches'

  # handle photo upload
  put 'photo-upload', to: 'users#photo_upload', as: 'photo_upload'
end
