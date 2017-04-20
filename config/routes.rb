Rails.application.routes.draw do
  devise_for :users
  root 'tasks#welcome_page'

  resources :tasks, except: [:show, :delete, :destroy]
  resources :groups, only: [:new, :create]
  resources :users, only: [:index, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
