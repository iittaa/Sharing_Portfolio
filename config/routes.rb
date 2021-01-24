Rails.application.routes.draw do
  resources :contacts, only:[:new, :create]
  root  "users#home"
  resources :users do
    collection do
      get :home
      get :term
    end
  end
  resources :sessions, only:[:new, :create, :destroy]
  resources :password_resets, only:[:new, :create, :edit, :update]
  resources :posts do
    resources :comments, only:[:create, :destroy, :edit, :update]
  end
  resources :stocks, only:[:create, :destroy, :index]
  resources :tags, only:[:show, :index]
  resources :comments, only:[:edit, :update]
end
