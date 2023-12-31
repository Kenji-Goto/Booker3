Rails.application.routes.draw do
  devise_for :users
  
  
  root to: 'homes#top'
  get 'home/about' => "homes#about", as: "home"
  
  resources :users, only: [:show,:index,:edit,:update]
  resources :books, only: [:index,:create,:show,:edit,:destroy,:update,:destroy] do
     resources :book_comments, only: [:create, :destroy]
     resource :favorites, only: [:create, :destroy]
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
