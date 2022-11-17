Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'sessions/login'
  get 'welcome', to: 'sessions#welcome'
  resources :admins, only: [:new, :create]

  resources :groups do
    member do
      get :code
      get :to_quiz
    end
  end

  get 'quiz/welcome'
  get 'quiz/final'
  get 'quiz/quiz'
  post 'quiz/attempt'
end
