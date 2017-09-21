Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root "welcome#index"
  get 'welcome', to: "welcome#index", as: :welcome

  ActiveAdmin.routes(self)
  devise_for :users

  resources :profiles, except: [:index]

  resources :personalities
  namespace :personalities do
    get 'token_inputs/index'
  end

  resources :content, only: [:index]
  resources :books, controller: 'content', type: 'book'
  resources :bands, controller: 'content', type: 'band'
  resources :games, controller: 'content', type: 'game'
  resources :movies, controller: 'content', type: 'movie'

  concern(:searchable) { get 'search_names/index' }
  namespace :content, module: 'content_namespace' do
    concerns :searchable
    get 'token_inputs/index'
  end
  namespace(:books, module: 'content_namespace', type: 'book') { concerns :searchable }
  namespace(:bands, module: 'content_namespace', type: 'band') { concerns :searchable }
  namespace(:games, module: 'content_namespace', type: 'game') { concerns :searchable }
  namespace(:movies, module: 'content_namespace', type: 'movie') { concerns :searchable }

  #TODO: 1) chosen-like approach without explicit join model makes future changes cost a little more.
  #TODO: maybe think twice before implementing in real projects
  #TODO: 2) think about resourcing
  post 'content_personalities/create', to: 'content_personalities#create', as: :create_content_personalities
  get 'content_personalities/:content_id/edit', to: 'content_personalities#edit', as: :edit_content_personalities
  post 'personality_content/create', to: 'personality_content#create', as: :create_personality_content
  get 'personality_content/:personality_id/edit', to: 'personality_content#edit', as: :edit_personality_content

  resources :posts, except: [:new, :index] do
    scope module: :posts do
      #TODO: this is resources, rewrite
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

  get 'recommendations', to: 'recommendations#index', as: :recommendations
end
