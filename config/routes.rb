Rails.application.routes.draw do

  # Admin namespace for administrative routes
  namespace :admin do
    resources :ads
  end

  # Routes for managing jobs
  resources :jobs

  # Routes for managing products
  resources :products

  # Routes for managing business sessions (login, logout)
  resources :b_sessions, only: [:new, :create, :destroy]

  # Routes for managing businesses and associated products and jobs
  resources :businesses, except: [:index] do
    resources :products
    resources :jobs
    member do
      get 'edit_password'
      patch 'update_password'
    end
  end

  resources :chat_chambers do
    resources :chat_messages
  end  

  # Routes for managing user sessions (login, logout)
  resources :sessions, only: [:new, :create, :destroy]

  # Routes for managing notifications
  resources :notifications, only: [:index] do
    member do
      patch :mark_as_read
    end
  end

  # Routes for managing microposts and associated comments
  resources :microposts, only: [:create, :destroy] do
    resources :comments, only: [:create, :destroy]
  end

  # Routes for managing relationships (follow, unfollow)
  resources :relationships, only: [:create, :destroy]

  # Routes for managing users and associated relationships, microposts
  resources :users do
    member do
      get :following, :followers
      get 'edit_password'
      patch 'update_password'
    end
  end

  # Routes for managing subscriptions
  resources :subscriptions

  # Route for canceling subscription
  post 'subscriptions/:id/cancel', to: 'subscriptions#cancel', as: :cancel_subscription

  # Static Pages
  root 'static_pages#home'
  get '/about',    to: 'static_pages#about'
  get '/howto',    to: 'static_pages#howto'
  get '/contact',  to: 'static_pages#contact'
  post 'send_contact', to: 'static_pages#send_contact'
  get '/eula',     to: 'static_pages#eula'
  get '/admin',    to: 'static_pages#admin'
  get '/android',  to: 'static_pages#android_privacy'

  # Users Paths
  get    '/signup',   to: 'users#new'
  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy', as: :logout

  # Aliases for business login/logout
  get 'b_login', to: 'b_sessions#new', as: :b_login
  delete 'b_logout', to: 'sessions#destroy', as: :b_logout
end
