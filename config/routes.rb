Rails.application.routes.draw do
  root 'tops#index'
  resources :blogs
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
end
