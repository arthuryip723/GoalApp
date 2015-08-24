Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :goals do
    member do
      post :complete
    end
  end
  resource :session, only: [:new, :create, :destroy]
end
