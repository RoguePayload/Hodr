Rails.application.routes.draw do
  get 'b_sessions/new'
  get 'b_sessions/create'
  get 'b_sessions/destroy'
  get 'businesses/new'
  get 'businesses/create'
  get 'businesses/show'
  get 'messages/create'
  get 'boards/new'
  get 'boards/create'
  get 'boards/show'
  get 'boards/index'
  get 'sessions/new'

  # Set Root Path #
  root 'static_pages#home'

  # Set Static Page Paths #
  get '/about',    to: 'static_pages#about'
  get '/howto',    to: 'static_pages#howto'
  get '/contact',  to: 'static_pages#contact'
  get '/eula',     to: 'static_pages#eula'
  get '/admin',    to: 'static_pages#admin'
  get '/android',  to: 'static_pages#android_privacy'


  # Set Users Paths #
  get    '/signup',   to: 'users#new'
  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'

  # Set Project Resources #
  resources :users do
     member do
        get :following, :followers
        get 'edit_password', to: 'users#edit_password'
        patch 'update_password', to: 'users#update_password'
     end
  end
  resources :microposts,          only: [:create, :destroy]do
    resources :comments, only: [:create, :destroy]
  end
  resources :relationships,       only: [:create, :destroy]
  resources :boards do
    member do
      get :fetch_messages
    end
    resources :messages, only: [:create]
  end
  get '/microposts', to: 'users#show'
  resources :businesses, only: [:new, :create, :show, :edit, :update]
  get 'b_login', to: 'b_sessions#new', as: :b_login
  post 'b_login', to: 'b_sessions#create'
  delete 'b_logout', to: 'b_sessions#destroy', as: :b_logout


end
