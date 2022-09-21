Rails.application.routes.draw do
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
