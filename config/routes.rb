Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  root 'users#index'
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[create destroy]
      resources :likes, only: %i[create]
    end
  end

  namespace :api, defaults: {format: 'json'} do
    post 'auth/login', to: 'authentication#authenticate'

    resources :users, only: %i[index show] do
      resources :posts, only: %i[index show ] do
        resources :comments, only: %i[index create]
      end
  end
end
end
