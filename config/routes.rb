Rails.application.routes.draw do
  get 'sessions/new'
  get '/customer_signup', to: 'customer_users#new'
  post '/customer_signup', to: 'customer_users#create'
  get '/store_signup', to: 'store_users#new'
  post '/store_signup', to: 'store_users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/inquiry_replies/:id', to: 'inquiries#edit', as: :reply_inquiry
  patch '/inquiry_replies/:id', to: 'inquiries#update', as: :reply_update_inquiry
  root 'static_pages#home'

  resources :customer_users
  resources :store_users
  resources :store_users do
    member do
      get :products
      post :products
    end
  end
  resources :products, only: [:create, :edit, :update, :destroy]
  resources :appointments, only: [:create, :destroy]
  resources :inquiries, only: [:index, :new, :create]
end
