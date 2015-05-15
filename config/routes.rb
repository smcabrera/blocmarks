Rails.application.routes.draw do
  devise_for :users

  # Using high_voltage gem for static landing pages
  root to: "homes#show"
  get 'pages/home' => 'high_voltage/pages#show', id: 'home'

  resources :topics do
    resources :bookmarks
  end

  resources :users, only: [:update]
end
