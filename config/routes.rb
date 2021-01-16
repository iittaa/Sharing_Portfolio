Rails.application.routes.draw do
  root  "users#home"
  resources :users do
    collection do
      get :home
    end
  end
  resources :sessions, only:[:new, :create, :destroy]
  resources :password_resets, only:[:new, :create, :edit, :update]
  resources :posts
  resources :stocks, only:[:create, :destroy, :index]
  resources :tags do
    get 'posts', to: 'posts#search'
  end
end
