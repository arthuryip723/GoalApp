Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :goals do
    member do
      post :complete
      post :cheer
    end
  end
  resource :session, only: [:new, :create, :destroy]
  resources :comments, only: [:create]
end
