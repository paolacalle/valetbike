Rails.application.routes.draw do

  get '/login', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create', as: 'sessions'
  delete '/sessions', to: 'sessions#destroy'

  get '/users/show', to: 'users#show'


  resources :categories do 
    member do 
      #adds delete action since not added by deafult 
      #optional, can simply destory 
      get :delete 
    end
      
  end 

  resources :memberships do 
    member do 
      get :delete
    end
      
  end 

  resources :users do 
    member do 
      get :delete
    end
      
  end 

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
