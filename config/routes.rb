Rails.application.routes.draw do
  get 'quiz/welcome'
  get 'quiz/final'
  get 'quiz/quiz'
  post 'quiz/attempt'
end
