StudyNetwork::Application.routes.draw do
  root 'pages#home'

  resources :users do
    get 'registrations/dept', to: 'registrations#dept'
    get 'registrations/search', to: 'registrations#search_courses'
    resources :registrations
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
