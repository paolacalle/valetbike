Rails.application.routes.draw do

  get '/login', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create', as: 'sessions'
  delete '/sessions', to: 'sessions#destroy'

  get '/users/show', to: 'users#show'


  post 'sessions', to: 'sessions#create', as: 'sessions'
  delete 'sessions', to: 'sessions#destroy'

  #Sessions routes
  # get '/login', to: 'sessions#new'
  # post '/login', to: 'sessions#create'
  # post 'logout', to: 'sessions#destroy'
  # get 'logout', to: 'sessions#destroy'

  # get 'sign_up', to: 'users#new'
  # post 'sing_up', to: 'users#create'

  resources :users, only: [:new, :create, :index, :show]
  resources :sessions, only: [:new, :create, :destroy]
      
  # end 

  resources :stations, only: [:index]
  resources :bikes, only: [:index] 


  root 'home#index' #homepage 
  
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



