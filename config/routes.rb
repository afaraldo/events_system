Rails.application.routes.draw do
  resources :events do
    resources :event_registrations, only: [:new, :create, :show, :edit, :update, :destroy]
  end

  resources :attendees
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "events#index"

  authenticate :user, ->(user) { user.role_admin? } do
    mount GoodJob::Engine => 'good_job'
  end

  namespace :api do
    namespace :v1 do
      get 'sessions/create'
      get 'sessions/destroy'
      resources :events
      devise_scope :user do
        post 'login', to: 'sessions#create'
        delete 'logout', to: 'sessions#destroy'
      end
    end
  end
end
