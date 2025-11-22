Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :lists do
  resources :bookmarks, only: [:new, :create, :edit, :update], shallow: true
end
resources :bookmarks, only: [:destroy]

  root "pages#home"
end
