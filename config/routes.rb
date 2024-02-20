Rails.application.routes.draw do

  # Set Root Path #
  root 'static_pages#home'

  # Set Static Page Paths #
  get '/about',    to: 'static_pages#about'
  get '/howto',    to: 'static_pages#howto'
  get '/contact',  to: 'static_pages#contact'

  # Set Users Paths #
  get '/signup',   to: 'users#new'
end
