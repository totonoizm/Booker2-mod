Rails.application.routes.draw do
  get '/users/sign_out' => 'devise/sessions#destroy'
  get 'home/about' => 'books#about'
  get 'books/top' => 'books#top'
  devise_for :users
  root 'books#top'
  resources :books
    resources :users, only: [:index, :show, :edit, :destroy, :update  ]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
