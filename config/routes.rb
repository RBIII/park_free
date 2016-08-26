Rails.application.routes.draw do
  root 'parking_areas#index'

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :parking_areas do
    resources :verifications, only: [:create, :update]
    resources :reviews, except: [:show, :index]
    post 'redirect_to_new_from_map', on: :collection
  end

  resources :reviews, only: [] do
    resources :comments, except: [:show, :index]
    resources :votes, only: [] do
      collection do
        post 'upvote'
        post 'downvote'
      end
    end
  end
end
