Rails.application.routes.draw do
  get 'sessions/new'
  get '/customer_signup', to: 'customer_users#new'
  post '/customer_signup', to: 'customer_users#create'
  get '/store_signup', to: 'store_users#new'
  post '/store_signup', to: 'store_users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/appointments?product_id=:product_id&store_user_id=:store_user_id&product_name=:product_name',
       to: 'appointments#create', as: :create_appointment
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
end
