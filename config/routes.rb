Rails.application.routes.draw do
  root "users#index"

  resources :users do
    resource :profile
  end
end
