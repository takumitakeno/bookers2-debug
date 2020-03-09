Rails.application.routes.draw do
  root 'home#top'
  get 'home/about' => "home#about"
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    member do
     get :following, :followers
    end
  end
  resources :books do
  	resources :book_comments,only: [:create, :destroy]
    resource :favorite,only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  post 'users' => 'users/#show'
end
