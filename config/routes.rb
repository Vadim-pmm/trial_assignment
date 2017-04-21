Rails.application.routes.draw do
  devise_for :users
  root 'tasks#welcome_page'

  resources :tasks, except: [:show, :delete, :destroy]
  get 'tasks/:id/accept_task', to: 'tasks#accept_task', as: 'accept'
  get 'tasks/:id/decline_task', to: 'tasks#decline_task', as: 'decline'
  get 'tasks/:id/mark_finished', to: 'tasks#mark_finished', as: 'finished'
  resources :groups, only: [:new, :create]
  resources :users, only: [:index, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
