Rails.application.routes.draw do
  devise_for :users

  resources :users, only: %i[index] do
    collection do
      get :requested_to_me
      get :my_requests
      get :my_friends
    end
  end

  resources :friendships do
    member do
      post :accept
      delete :reject
      delete :cancel
    end
  end

  resources :posts, only: %i[index new create destroy] do
    member do
      resources :likes, only: %i[create]
      resources :comments, only: %i[index create]
    end
  end

  root 'posts#index'
end
