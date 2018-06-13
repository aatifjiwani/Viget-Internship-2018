Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles, except: [:edit, :update]
  resources :users, except: [:index]
    
  root 'articles#index'    
end
