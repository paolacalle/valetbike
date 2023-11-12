Rails.application.routes.draw do

  root 'home#index' #homepage 

  get 'users/show', to: 'users#show'

  #Sessions routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'
  resources :users
  # resources :users, only: [:new, :create, :index, :show]
  resources :memberships, only: [:new, :create, :index, :show]
  resources :sessions, only: [:new, :create, :destroy]
      
  # end 

  resources :stations, only: [:index]
  resources :bikes, only: [:index] 

  resources :payments, only: [:index, :new, :create]
  get 'payments', to: 'payments#index', as: 'payments'
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



