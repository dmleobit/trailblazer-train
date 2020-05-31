Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  resources :users, only: %i[index show update] do
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
      post :like
      resources :comments, only: %i[index create] do
        post :like, on: :member
      end
    end
  end

  root 'posts#index'
end
