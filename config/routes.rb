Rails.application.routes.draw do

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
end

  # get 'categories/index'
  # get 'categories/show'
  # get 'categories/edit'
  # get 'categories/delete'
  # get 'categories/new'


  # get 'memberships/index'
  # get 'memberships/show'
  # get 'memberships/new'
  # get 'memberships/edit'
  # get 'memberships/delete'


  # get 'users/index'
  # get 'users/show'
  # get 'users/new'
  # get 'users/edit'
  # get 'memberships/delete'