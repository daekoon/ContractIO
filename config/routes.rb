Rails.application.routes.draw do
  get 'users/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users,  only: [:show,]

  get '/contracts/select', to: 'contracts#select'
  post '/contracts/generate', to: 'contracts#generate'
  post '/contracts/edit', to: 'contracts#editpost'
  resources :contracts, only: [:show, :create, :new, :edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
