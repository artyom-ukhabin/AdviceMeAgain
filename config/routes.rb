Rails.application.routes.draw do
  root "welcome#index"
  get 'welcome/index', as: :welcome

  concern :searchable do
    collection do
      get :search
    end
  end

  ActiveAdmin.routes(self)
  devise_for :users

  resources :profiles, except: [:index]

  resources :personalities

  resources :content, only: [:index]
  resources :books, controller: 'content', type: 'book', concerns: :searchable
  resources :bands, controller: 'content', type: 'band', concerns: :searchable
  resources :games, controller: 'content', type: 'game', concerns: :searchable
  resources :movies, controller: 'content', type: 'movie', concerns: :searchable

  resources :posts, except: [:new, :index] do
    scope module: :posts do
      get 'likes/index'
      get 'likes/create'
      get 'likes/destroy'

      get 'reposts/index'
      get 'reposts/create'
    end
  end

  resources :content_rates, only: [:create, :update, :destroy]
  resources :personality_rates, only: [:create, :update, :destroy]

  resources :content_reviews, only: [:edit, :create, :update, :destroy] do
    scope module: :content_reviews do
      resources :votes, only: [:index, :create, :update, :destroy]
    end
  end
  resources :personality_reviews, only: [:edit, :create, :update, :destroy] do
    scope module: :personality_reviews do
      resources :votes, only: [:index, :create, :update, :destroy]
    end
  end

  resources :content_review_votes, only: [:create, :update, :destroy]
  resources :personality_review_votes, only: [:create, :update, :destroy]
end
