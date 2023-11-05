Rails.application.routes.draw do
  get 'memberships/index'
  get 'memberships/show'
  get 'memberships/new'
  get 'memberships/edit'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/edit'
  resources :stations, only: [:index]
  resources :bikes, only: [:index]

  root 'home#index' 
end

