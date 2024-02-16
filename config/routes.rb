Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :movies, only: %i[index show]
  resources :actors, only: %i[index show]

  root 'movies#index'
end
