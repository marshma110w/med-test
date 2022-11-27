Rails.application.routes.draw do
  root to: 'sessions#welcome'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  get 'by_code', to: 'sessions#by_code'
  resources :admins, only: [:new, :create]

  resources :groups do
    member do
      get :code
    end
  end

  get 'quiz/:group_id/welcome', to: 'quiz#welcome', as: :welcome_code
  post 'quiz/:group_id/personal_info', to: 'quiz#personal_info', as: :personal_info
  get 'quiz/final'
  get 'quiz/:group_id/quiz', to: 'quiz#quiz', as: :quiz_code
  post 'quiz/:group_id/attempt', to: 'quiz#attempt'
end
