# frozen_string_literal: true

Rails.application.routes.draw do
  resources :projects, only: [:new, :create, :show, :index, :destroy]

  get '/my-projects', to: 'projects#my_projects', as: 'my_projects'
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

  # route for showing chats
  get '/chats/:id', to: 'chats#show', as: 'chat'

  # creating a new chat
  post '/chats/:match_id', to: 'chats#create', as: 'new_chat'

  # setting featured project
  post '/featured-project/:project_id',  to: 'projects#set_featured_project', as: 'featured_project'

  resources :messages
end
