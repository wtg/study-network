StudyNetwork::Application.routes.draw do
  root 'pages#home'

  resources :users do
    resources :registrations, only: [:new, :create, :edit, :index]
  end

  resources :courses do
    get 'connections'
    get 'messages'
    resources :posts do
      resources :replies 
    end
  end

  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'

end
