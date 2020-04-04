Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root to: "tasks#index"
  
  # ログイン処理用定義
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # ユーザー追加用定義
  get 'signup', to: 'users#new' 
  
  resources :users, only: [:new, :create]
  resources :tasks
end
