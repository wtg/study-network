StudyNetwork::Application.routes.draw do
  root 'pages#home'

  resources :users

  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'

end
