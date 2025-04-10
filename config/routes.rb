Rails.application.routes.draw do
  root 'home#index'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  resources :reservations, only: [:index, :new, :create, :show] do
    collection do
      post :confirm
    end
  end
  
  resources :checkouts, only: [:create]
  
  resources :prayer_types, only: [:index]
  
  post 'webhooks/stripe', to: 'webhooks#stripe'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
