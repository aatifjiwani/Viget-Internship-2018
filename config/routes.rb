Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles, except: [:edit, :update]
  resources :users, except: [:index]
  resource :sessions, except: [:index, :edit, :update, :show]
    
  root 'articles#index'    
end
