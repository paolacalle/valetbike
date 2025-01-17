Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :locations

  root 'home#index' #homepage 
  get 'home', to: 'home#index'
  post 'home', to: 'home#index'

  get '/about_us', to: 'about_us#index', as: 'about_us'

  get 'users/show', to: 'users#show'

  #Sessions routes
  post '/geolocation/save_coordinates', to: 'users#save_coordinates'
  # resources :users, only: [:new, :create, :index, :show]
  resources :memberships, only: [:new, :create, :index, :show]
      

  resources :stations, only: [:index, :show]
  resources :bikes, only: [:index] 

  resources :payments, only: [:new]
  get 'payments', to: 'payments#index', as: 'payments'
  post 'payments', to: 'payments#create'

  #Rentals routes
  resources :rentals, only: [:index, :new, :create, :update, :show]
  post 'rentals', to: 'rentals#create'
  patch '/return/:id', to: 'rentals#update', as: 'return'

  # Memberships routes
  resources :memberships, only: [:new, :create, :update]
  get '/memberships/:id', to: 'memberships#show'
  delete '/memberships/:id', to: 'memberships#destroy'
  
  #Feedback routes
  get '/feedback', to: 'feedback#new'

  post 'feedback', to: 'feedback#create'

  #Review routes
  get 'review', to: 'reviews#new'
  post 'review', to: 'reviews#create'
end



