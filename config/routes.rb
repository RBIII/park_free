Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users
  root 'parking_areas#index'

  resources :parking_areas do
    resources :verifications, only: [:create, :update]
    resources :reviews, except: [:show, :index]
    post 'redirect_to_new_from_map', on: :collection
  end

  resources :reviews, only: [] do
    resources :comments, except: [:show, :index]
  end
end
