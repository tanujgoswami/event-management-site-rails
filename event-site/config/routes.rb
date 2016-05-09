Rails.application.routes.draw do
  get 'tags/:tag', to: 'events#index', as: :tag

  devise_for :users
  resources :events
end
