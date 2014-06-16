Myapp::Application.routes.draw do
  devise_for :users
  get "home/index"
  root to: 'episodes#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :episodes
end
