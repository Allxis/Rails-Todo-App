Rails.application.routes.draw do
  devise_for :users
  resources :todos
  get 'auth/login'
  get 'task/newTask'
  get 'home/about'
  root 'home#index'
end
