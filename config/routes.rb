Rails.application.routes.draw do


  root 'home#index'


  get 'home/sign_up'
  get 'home/index'
  get 'home/login'
  post 'home/login_attempt'
  get 'home/logout'

  get 'user/follow/:id', to: 'users#follow'
  get 'user/unfollow/:id', to: 'users#unfollow'







  resources :users do
    collection do
      get :search
    end
  end

  resources :posts do
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
