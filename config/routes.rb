Rails.application.routes.draw do

  root 'home#index' #homepage 
  get 'home', to: 'home#index'
  post 'home', to: 'home#index'

  get 'users/show', to: 'users#show'

  #Sessions routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'
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

  resources :payments, only: [:new]
  get 'payments', to: 'payments#index', as: 'payments'
  post 'payments', to: 'payments#create'

  # below not set up in the controller...but will need to just add the simple thing to the resources list above
  # get 'payments/:id' , to: 'payments#show', as: 'payment'
  # get 'payments/update'
  # get 'payments/edit'
  # get 'payments/destroy'


  #Rentals routes
  resources :rentals, only: [:index, :new, :create, :update]
  post 'rentals', to: 'rentals#create'
  get 'rentals/return', to: 'rentals#update', as: 'return'

  # below not set up in the controller...but will need to just add the simple thing to the resources list above
  # get 'rentals/:id' , to: 'rentals#show', as: 'rental' 
  # get 'rentals/edit'
  # get 'rentals/destroy'

  resources :checkouts_path
  resources :checkouts
  resources :subscriptions

  get "payments/index", to: "payments#index"

  namespace :user do
    root "products#index"
    resources :products, only: [:show]
    resources :charges, only: [:new, :create] do
      get "success", to: "charges#success"
      get "cancel", to: "charges#cancel"
    end

    resources :subscriptions, only: [:new, :create] do
      get "success", to: "subscriptions#success"
      get "cancel", to: "subscriptions#cancel"
      post "manage", to: "subscriptions#manage"
      get "manage-return", to: "subscriptions#manage_return"
    end
    resources :unsubscriptions, only: [:create]
  end

  Rails.application.routes.draw do
    resources :webhooks, only: :create
  end

  scope controller: :static do
    get :pricing
  end

end



