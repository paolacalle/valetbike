Rails.application.routes.draw do

  # get 'login', to: 'sessions#new', as: 'login'
  # post 'sessions', to: 'sessions#create', as: 'sessions'
  # delete 'sessions', to: 'sessions#destroy'

  get 'users/show', to: 'users#show'
  post 'sessions', to: 'sessions#create', as: 'sessions'
  delete 'sessions', to: 'sessions#destroy'

  #Sessions routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
  get 'logout', to: 'sessions#destroy'

  get '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'

  # resources :users, only: [:new, :create, :index, :show]
  resources :memberships, only: [:new, :create, :index, :show]
  resources :sessions, only: [:new, :create, :destroy]
      
  # end 

  resources :stations, only: [:index]
  resources :bikes, only: [:index] 


  root 'home#index' #homepage 

  #Payments routes
  resources :payments, only: [:index, :new, :create]
  post 'payments', to: 'payments#create'

  # below not set up in the controller...but will need to just add the simple thing to the resources list above
  # get 'payments/:id' , to: 'payments#show', as: 'payment'
  # get 'payments/update'
  # get 'payments/edit'
  # get 'payments/destroy'


  #Rentals routes
  resources :rentals, only: [:index, :new, :create]
  post 'rentals', to: 'rentals#create'

  # below not set up in the controller...but will need to just add the simple thing to the resources list above
  # get 'rentals/:id' , to: 'rentals#show', as: 'rental' 
  # get 'rentals/update'
  # get 'rentals/edit'
  # get 'rentals/destroy'

end



