Rails.application.routes.draw do
  get 'sessions/new'

  # Set Root Path #
  root 'static_pages#home'

  # Set Static Page Paths #
  get '/about',    to: 'static_pages#about'
  get '/howto',    to: 'static_pages#howto'
  get '/contact',  to: 'static_pages#contact'
  get '/eula',     to: 'static_pages#eula'
  get '/admin',    to: 'static_pages#admin'


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

  get '/microposts', to: 'users#show'

end
