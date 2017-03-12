Rails.application.routes.draw do
  root "welcome#index"

  get 'welcome/index', as: :welcome

  ActiveAdmin.routes(self)
  devise_for :users

  resources :profiles, except: [:index]
end
