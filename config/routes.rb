Rails.application.routes.draw do
  devise_for :users
  root 'parking_areas#index'

  resources :parking_areas do
    resources :verifications, only: [:create, :update]
    resources :comments, except: [:show, :index]
    post 'redirect_to_new_from_map', on: :collection
  end
end
