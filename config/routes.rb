Rails.application.routes.draw do
  devise_for :users
 root to:"items#index"

  #createアクションを呼び出すルーティング
 resources :items, only: [:index, :new, :create]
end
