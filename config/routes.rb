Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  root 'home#index'

  resources :events
  resources :tags
  
  get "/register/:id" => "events#register", :as => :register
  get "/users" => "users/users#index"
  get "/users/:id" => "users/users#show", :as => :user
  get "/api/taggings" => "api/events#taggings"
  get "/api/events" => "api/events#events"
  get "/api/tags" => "api/events#tags"
  get "/api/tagids" => "api/events#tagids"
  get "/api/event/:id" => "api/events#event"
  post 'api/register', to: 'api/users#register'
  post 'api/login', to: 'api/users#login'
  post 'api/logout', to: 'api/users#logout'
  get 'api/checkregister', to: 'api/users#checkregister'
  get 'api/eventregister', to: 'api/users#eventregister'
  get 'api/eventunregister', to: 'api/users#eventunregister'
  get 'api/getid', to: 'api/users#getid'
  get 'api/getuser', to: 'api/users#getuser'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  get '/confirmation_pending' => 'home#after_registration_path'
  # Defines the root path route ("/")
  # root "articles#index"
end

