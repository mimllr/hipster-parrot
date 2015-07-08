Rails.application.routes.draw do
  root 'home#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/deck', to: 'posts#deck'
  get "post/new_release" => 'project#new_release', :as => :new_release

  resources :users do
    member do
      get :follow
      get :unfollow
    end
  end
  resources :posts
end
