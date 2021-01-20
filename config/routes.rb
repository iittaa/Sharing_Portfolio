Rails.application.routes.draw do
  root  "users#home"
  resources :users do
    collection do
      get :home
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
