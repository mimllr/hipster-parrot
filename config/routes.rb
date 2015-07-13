Rails.application.routes.draw do
  root 'home#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/deck', to: 'posts#deck'
  get 'users/:id/followers/', to: 'users#followers', as: 'followers'
  get 'users/:id/following/', to: 'users#following', as: 'following'
  
  resources :account_activations, only: [:edit]

  resources :users do
    member do
      get :follow
      get :unfollow
    end
  end

  resources :posts
end
