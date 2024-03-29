# frozen_string_literal: true

Rails.application.routes.draw do
  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  get '/signup',  to: 'users#new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'static_pages#home'
  resources :users

  get '/login',      to: 'sessions#new'
  post '/login',     to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
