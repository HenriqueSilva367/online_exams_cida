Rails.application.routes.draw do
  get "exam_sessions/index"
  get "exam_sessions/show"
  get "exams/index"
  get "exams/show"
  get "topics/index"
  get "topics/show"
  devise_for :users

  # Defines the root path route ("/")
  devise_scope :user do
    authenticated :user do
      root 'topics#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :topics, only: [:index, :show] do
    resources :exams, only: [:index, :show]
  end

  resources :exams, only: [] do
    resources :exam_sessions, only: [:create]
  end

  resources :exam_sessions, only: [:index, :show, :update] do
    member do
      patch :cancel
      patch :finish
      get :results
    end
  end

  namespace :admin do
    # Full CRUD for entities
    root "topics#index"
    resources :users
    resources :topics do
      resources :exams, shallow: true
    end
    resources :exams, only: [] do
      resources :questions, shallow: true
    end
    resources :questions, only: [] do
      resources :answers, shallow: true
    end
    resources :exam_sessions, only: [:index, :show]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
