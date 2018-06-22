Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :votes, only: [:create, :update]
  
  resources :articles, except: [:edit, :update]

  resources :comments, only: [:create]
  
  resources :users, except: [:index]
  resource :sessions, only: [:new, :create, :destroy]
  
  #Password Reset
  resource :password_reset, except: [:index, :show, :destroy]
  
    
  root 'articles#index'    
end
