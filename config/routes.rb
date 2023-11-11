Rails.application.routes.draw do

  root 'home#index' #homepage 

  get 'users/show', to: 'users#show'

  #Sessions routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'

  # resources :users, only: [:new, :create, :index, :show]
  resources :memberships, only: [:new, :create, :index, :show]
  resources :sessions, only: [:new, :create, :destroy]
      
  # end 

  resources :stations, only: [:index]
  resources :bikes, only: [:index] 
  
  get 'payments', to: 'payments#index', as: 'payments'
  post 'payments', to: 'payments#create'
  get 'payments/new', to: 'payments#new', as: 'new_payment'
  get 'payments/:id' , to: 'payments#show', as: 'payment'
  get 'payments/update'
  get 'payments/edit'
  get 'payments/destroy'

  get 'rentals', to: 'rentals#index', as: 'rentals'
  post 'rentals', to: 'rentals#create'
  get 'rentals/new', to: 'rentals#new', as: 'new_rental'
  get 'rentals/:id' , to: 'rentals#show', as: 'rental'
  get 'rentals/update'
  get 'rentals/edit'
  get 'rentals/destroy'




end



