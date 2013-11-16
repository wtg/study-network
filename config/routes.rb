StudyNetwork::Application.routes.draw do
  root 'pages#home'

  resources :users do
    resources :registrations, only: [:new, :create]
  end

  resources :courses

  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'

end
