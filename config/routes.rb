Myapp::Application.routes.draw do
  get "home/index"
  root to: 'episodes#index'

  resources :episodes
end
