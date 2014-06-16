Myapp::Application.routes.draw do
  get "home/index"
  root to: 'episodes#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :episodes
end
