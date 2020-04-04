Rails.application.routes.draw do
  
  root to: "tasks#index"
  
  # ログイン処理用定義
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # ユーザー追加用定義
  get 'signup', to: 'users#new' 
  
  resources :users, only: [:create]
  resources :tasks
end
