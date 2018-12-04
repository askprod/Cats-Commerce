Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :home, :path => "cat"
  resources :charges
  resources :order, only: [:index, :create]
  resources :cart, only: [:index, :create, :destroy] do
    member do
      get 'empty'
    end
  end
  resources :admin, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
