GmailAlerts::Application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  root to: 'sessions#new'
  resources :sessions, only: :index
  get "/auth/:provider/callback" => 'sessions#create'
end