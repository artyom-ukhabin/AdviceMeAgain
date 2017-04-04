Rails.application.routes.draw do
  root "welcome#index"

  get 'welcome/index', as: :welcome

  ActiveAdmin.routes(self)
  devise_for :users

  resources :profiles, except: [:index]
  resources :personalities

  resources :content, only: [:index]
  resources :books, controller: 'content', type: 'book'
  resources :bands, controller: 'content', type: 'band'
  resources :games, controller: 'content', type: 'game'
  resources :movies, controller: 'content', type: 'movie'
end
