Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :edit, :update]
  resources :teachers, only: [:new, :create]
  resources :students, only: [:new, :create]
  resources :parents, only: [:new, :create]
  resources :grades
end
