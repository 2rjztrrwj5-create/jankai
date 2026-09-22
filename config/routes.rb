Rails.application.routes.draw do
  resource :session, only: %i[ create destroy ]
  get "login", to: "sessions#new"
  resources :passwords, param: :token
  root to: "homes#top"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "signup", to: "registrations#new"
  post "signup", to: "registrations#create"

  resources :posts do
    resources :comments, only: %i[ create ]
  end
  resources :comments, only: %i[ destroy ]

  resources :groups, only: %i[ index new create show ] do
    resources :applications, only: %i[ create ]
    member do
      patch "approve/:user_id", to: "groups#approve", as: :approve
      patch "reject/:user_id", to: "groups#reject", as: :reject
    end
  end

  namespace :admin do
    get "login", to: "sessions#new"
    resource :session, only: %i[ create destroy ]
    resources :users, only: %i[ index show ] do
      member do
        delete "withdraw"
      end
    end
  end
  get "mypage", to: "users#mypage"
  get "users/:id", to: "users#show", as: :user
  get "users/edit", to: "users#edit"
  patch "users/edit", to: "users#update"
  delete "users", to: "users#destroy"

  get "search", to: "searches#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
