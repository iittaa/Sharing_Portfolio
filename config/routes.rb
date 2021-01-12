Rails.application.routes.draw do
  root  "users#home"
  resources :users do
    collection do
      get :home
    end
  end
  resources :sessions, only:[:new, :create, :destroy]
end
