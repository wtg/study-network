StudyNetwork::Application.routes.draw do
  root 'pages#home'

  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'

  resource :user

end
