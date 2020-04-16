Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  root 'static_pages#home'

end
