Rails.application.routes.draw do
  resources :stations, only: [:index]
  resources :bikes, only: [:index]

  root 'home#index' 
end

