Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'users#home'
  post '/users/guest_sign_in', to: 'users#new_guest'
  post '/posts/:post_id/stocks', to: 'stocks#create'
  delete '/posts/:post_id/stocks', to: 'stocks#destroy'
  post '/posts/:post_id/likes', to: 'likes#create'
  delete '/posts/:post_id/likes', to: 'likes#destroy'
  resources :users, only: [:index, :edit, :show, :update, :destroy] do
    member do
      get :following, :followers
    end
    collection do
      get :home
      get :term
      get :contact
    end
  end

  resources :posts do
    collection do
      get :like_posts
      get :follow_posts
      post :new, path: :new, as: :new, action: :back
      post :confirm
    end
    resources :comments, only: %i[create destroy]
  end
  resources :notifications, only: [:index]
  
  resources :relationships, only: %i[create destroy]
  resources :messages, only: [:create]
  resources :rooms, only: %i[create show index]

  
  # resources :contacts, only: [:new]
  # namespace :admin do
  #   resources :users, only: %i[index show destroy]
  #   resources :posts, only: %i[index show edit update destroy]
  # end

  # resources :tags, only: %i[show index]
  # get "auth/:provider/callback", to: "users#twitter_create"
  # resources :sessions, only:[:new, :create, :destroy]
  # resources :password_resets, only:[:new, :create, :edit, :update]
end
