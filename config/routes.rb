Rails.application.routes.draw do

  root "static_pages#home"
        # soutien (pédagogie), assistance (interface, infographie) support (technique)
  get '/help',    to: 'static_pages#help'
        # à propos
  get '/about',   to: 'static_pages#about'
        # avis échange message commerce annonce
  get '/contact', to: 'static_pages#contact'
        # inscription
   get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  resources :users do
    member do
          # abonnements abonnés
      get :following, :followers
    end
  end
          # connexion
     get '/login',  to: 'sessions#new'
    post '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
            # activation réinitialisation
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
             # ...
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
