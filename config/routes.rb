Rails.application.routes.draw do
  resources :posts
  resources :comments
  post "toggle_like" => "likes#toggle"

  get 'posts/index'
  root to: 'home#index'
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
