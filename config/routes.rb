Rails.application.routes.draw do
  devise_for :users
  root to: 'pets#index'
  resources :pets, only:[:index,:show]
  resources :orders, only:[:show,:create] do
    resources :payments, only:[:new]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
