Rails.application.routes.draw do
  get 'tags/:tag', to: 'events#index', as: :tag

  devise_for :users
  resources :events do
    get :join, to: 'events#join', as: 'join'
    get :accept_request, to: 'events#accept_request', as: 'accept_request'
    get :reject_request, to: 'events#reject_request', as: 'reject_request'
  end

    resources :users, only: :show
end
