Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'user/registrations' }
  root 'tasks#welcome_page'

  resources :tasks, except: [:show, :delete, :destroy]
  get 'tasks/:id/accept_task', to: 'tasks#accept_task', as: 'accept'
  get 'tasks/:id/decline_task', to: 'tasks#decline_task', as: 'decline'
  get 'tasks/:id/mark_finished', to: 'tasks#mark_finished', as: 'finished'
  get 'tasks/archive', to: 'tasks#index_archive', as: 'archive'

  resources :groups, only: [:new, :create, :destroy]
  resources :users, only: [:index, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
