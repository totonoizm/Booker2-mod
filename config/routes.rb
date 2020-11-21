Rails.application.routes.draw do
  get '/users/sign_out' => 'devise/sessions#destroy'
  get 'home/about' => 'books#about'
  get 'books/top' => 'books#top'
  post 'follow/:id' => 'relationships#create', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow' # フォロー外す
  devise_for :users
  root 'books#top'
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users do
    member do
      get :following, :followers
    end
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
