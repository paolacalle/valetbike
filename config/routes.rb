Rails.application.routes.draw do
  
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

  resources :stations, only: [:index]
  resources :bikes, only: [:index]
  # resources :rentals, only: [:index]
  # resources :payments, only: [:index]

  root 'home#index' 

end

