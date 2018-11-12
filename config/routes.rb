Rails.application.routes.draw do
  get 'home/about'
  root 'application#hello'
end
