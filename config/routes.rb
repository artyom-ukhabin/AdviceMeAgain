Rails.application.routes.draw do
  namespace :content_namespace do
    get 'genres/index'
  end

  mount Sidekiq::Web => '/sidekiq'

  root "welcome#index"
  get 'welcome', to: "welcome#index", as: :welcome

  ActiveAdmin.routes(self)
  devise_for :users

  resources :profiles, except: [:index]

  resources :personalities

  resources :content, only: [:index]
  resources :books, controller: 'content', type: 'book'
  resources :bands, controller: 'content', type: 'band'
  resources :games, controller: 'content', type: 'game'
  resources :movies, controller: 'content', type: 'movie'

  concern(:searchable) { get 'search_names/index' }
  concern(:with_genres) { get 'genres/:genre_name', to: "genres#index", as: :with_genre }

  namespace :content, module: 'content_namespace' do
    concerns :searchable
  end
  #TODO: remember this
  namespace(:books, module: 'content_namespace', type: 'book') { concerns [:searchable, :with_genres] }
  namespace(:bands, module: 'content_namespace', type: 'band') { concerns [:searchable, :with_genres] }
  namespace(:games, module: 'content_namespace', type: 'game') { concerns [:searchable, :with_genres] }
  namespace(:movies, module: 'content_namespace', type: 'movie') { concerns [:searchable, :with_genres] }

  resources :movie_genres
  resources :game_genres
  resources :band_genres
  resources :book_genres

  #TODO: 1) chosen-like approach without explicit join model makes future changes cost a little more.
  #TODO: maybe think twice before implementing in real projects
  #TODO: 2) think about resourcing
  post 'content_personalities/create', to: 'content_personalities#create', as: :create_content_personalities
  get 'content_personalities/:content_id/edit', to: 'content_personalities#edit', as: :edit_content_personalities
  post 'personality_content/create', to: 'personality_content#create', as: :create_personality_content
  get 'personality_content/:personality_id/edit', to: 'personality_content#edit', as: :edit_personality_content

  post 'content_genres/create', to: 'content_genres#create', as: :create_content_genres
  get 'content_genres/:content_id/edit', to: 'content_genres#edit', as: :edit_content_genres

  post 'book_genre_content/create', to: 'genre_content#create', type: 'book', as: :create_book_genre_content
  get 'book_genre_content/:genre_id/edit', to: 'genre_content#edit', type: 'book', as: :edit_book_genre_content
  post 'band_genre_content/create', to: 'genre_content#create', type: 'band', as: :create_band_genre_content
  get 'band_genre_content/:genre_id/edit', to: 'genre_content#edit', type: 'band', as: :edit_band_genre_content
  post 'movie_genre_content/create', to: 'genre_content#create', type: 'movie', as: :create_movie_genre_content
  get 'movie_genre_content/:genre_id/edit', to: 'genre_content#edit', type: 'movie', as: :edit_movie_genre_content
  post 'game_genre_content/create', to: 'genre_content#create', type: 'game', as: :create_game_genre_content
  get 'game_genre_content/:genre_id/edit', to: 'genre_content#edit', type: 'game', as: :edit_game_genre_content

  concern(:token_inputs) { get 'token_inputs/index', as: :token_inputs }
  namespace(:content_personalities) { concerns :token_inputs }
  namespace(:personality_content) { concerns :token_inputs }
  namespace(:content_genres) { concerns :token_inputs }
  namespace(:book_genre_content, module: 'genre_content', type: 'book') { concerns :token_inputs }
  namespace(:band_genre_content, module: 'genre_content', type: 'band') { concerns :token_inputs }
  namespace(:game_genre_content, module: 'genre_content', type: 'game') { concerns :token_inputs }
  namespace(:movie_genre_content, module: 'genre_content', type: 'movie') { concerns :token_inputs }

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
