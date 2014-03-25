StudyNetwork::Application.routes.draw do
  root 'pages#home'

  resources :users, only: [:show, :edit, :update, :destroy] do
    get 'registrations/dept', to: 'registrations#dept'
    get 'registrations/search', to: 'registrations#search_courses'
    resources :registrations, only: [:index, :new, :create, :edit]
  end

  resources :courses, only: [:show] do
    get 'connections'
    get 'messages'
    resources :posts, except: [:index] do
      resources :replies, only: [:new, :create, :destroy]
    end
  end

  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'

end
