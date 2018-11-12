Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  get '/about', to: 'static_pages#about'
  root 'static_pages#home'
end
