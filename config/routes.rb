Rails.application.routes.draw do
  resources :bookmarks

  devise_for :users

  root to: "homes#show"

  # Using high_voltage gem for static landing pages
  get 'pages/home' => 'high_voltage/pages#show', id: 'home'

  resources :users, only: [:update]
end
