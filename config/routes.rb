Rails.application.routes.draw do

  get 'sessions/login'
  post 'sessions/login_attempt'
  get 'sessions/logout'
  get 'sessions/home'
  get 'sessions/profile'
  get 'sessions/setting'



  resources :users
  resources :posts do
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
