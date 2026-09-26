Rails.application.routes.draw do
  resource :session, only: %i[ create destroy ]
  get "login", to: "sessions#new"
  resources :passwords, param: :token
  root to: "homes#top"

  get "signup", to: "registrations#new"
  post "signup", to: "registrations#create"

  resources :posts do
    resources :comments, only: %i[ create ]
    resources :applications, only: %i[ create ]
    member do
      patch "approve/:user_id", to: "posts#approve", as: :approve
      patch "reject/:user_id", to: "posts#reject", as: :reject
    end
  end
  resources :comments, only: %i[ destroy ]

  resources :groups, only: %i[ index show ] do
    resources :comments, only: %i[ create ]
  end

  namespace :admin do
    get "login", to: "sessions#new"
    resource :session, only: %i[ create destroy ]
    resources :users, only: %i[ index show ] do
      member do
        delete "withdraw"
      end
    end
    resources :groups, only: %i[ index destroy ]
    resources :comments, only: %i[ index destroy ]
  end
  
  get "mypage", to: "users#mypage"
  get "users/:id", to: "users#show", as: :user
  get "users/edit", to: "users#edit"
  patch "users/edit", to: "users#update"
  delete "users", to: "users#destroy"

  get "search", to: "searches#index"

  get "up" => "rails/health#show", as: :rails_health_check
end