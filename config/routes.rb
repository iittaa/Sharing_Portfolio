Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    # このpathを通して外部API認証が行われる。
    :omniauth_callbacks => 'users/omniauth_callbacks'
   }
  root  "users#home"
  post "/users/guest_sign_in", to: "users#new_guest"
  # get "auth/:provider/callback", to: "users#twitter_create"
  post "/posts/:post_id/stocks", to: "stocks#create"
  delete "/posts/:post_id/stocks", to: "stocks#destroy"
  resources :contacts, only:[:new, :create]
  resources :users do
    collection do
      get :home
      get :term
    end
  end
  namespace :admin do
    resources :users, only:[:index, :show, :destroy]
    resources :posts, only:[:index, :show, :edit, :update, :destroy]
  end
  # resources :sessions, only:[:new, :create, :destroy]
  resources :password_resets, only:[:new, :create, :edit, :update]
  resources :posts do
    resources :comments, only:[:create, :destroy]
  end
  resources :stocks, only:[:index]
  resources :tags, only:[:show, :index]
  resources :notifications, only: [:index]

  
end
