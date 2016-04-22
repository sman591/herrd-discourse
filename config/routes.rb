Herrd::Engine.routes.draw do
  root to: 'routes#index'
  get '/regenerate', to: 'routes#regenerate'
  get '/login', to: 'routes#login'
  get '/verify_plugin', to: 'routes#verify_plugin'
end
