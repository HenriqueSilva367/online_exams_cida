Rails.application.routes.draw do
  resource :profile, only: [:show, :edit, :update]
  devise_for :users

  authenticated :user do
    root to: 'topics#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'home#index'
  end

  get 'dashboard', to: 'topics#index'

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
    resources :exercise_authorizations, only: [:create, :destroy]
    resources :external_activities, only: [:create, :destroy]
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
