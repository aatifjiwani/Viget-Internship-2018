Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :comments, only: [:create] do
    resources :comments, only: [:create]
  end
  
  resources :articles, except: [:edit, :update] do
    resources :comments, only: [:create]
  end
  resources :users, except: [:index]
  resource :sessions, only: [:new, :create, :destroy]
  
  #Password Reset
  resource :password_reset, except: [:index, :show, :destroy]
  
    
  root 'articles#index'    
end
