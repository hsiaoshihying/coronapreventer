Rails.application.routes.draw do
  get '/customer_signup', to: 'customer_users#new'
  post '/customer_signup', to: 'customer_users#create'
  get '/store_signup', to: 'store_users#new'
  post '/store_signup', to: 'store_users#create'
  root 'static_pages#home'
  resources :customer_users
  resources :store_users
end
