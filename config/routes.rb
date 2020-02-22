Rails.application.routes.draw do
  get 'users/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users,  only: [:show,]

  get '/contracts/select', to: 'contracts#select'
  get '/contracts/explain', to: 'contracts#explain'
  post '/contracts/explained', to: 'contracts#explained'
  post '/contracts/generate', to: 'contracts#generate'
  post '/contracts/edit', to: 'contracts#editpost'
  post '/contracts/newclause', to: 'contracts#newclause'
  post '/contracts/deleteclause', to: 'contracts#deleteclause'
  get '/contracts/:id/printable', to: 'contracts#printable'
  resources :contracts, only: [:show, :create, :new, :edit]


  resources :terms,  only: [:show,]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
