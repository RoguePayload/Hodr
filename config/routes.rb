Rails.application.routes.draw do
  get 'sessions/new'

  # Set Root Path #
  root 'static_pages#home'

  # Set Static Page Paths #
  get '/about',    to: 'static_pages#about'
  get '/howto',    to: 'static_pages#howto'
  get '/contact',  to: 'static_pages#contact'

  # Set Users Paths #
  get    '/signup',   to: 'users#new'
  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'
  
  # Set Project Resources #
  resources :users
end
