DiscourseMobile::Engine.routes.draw do
  root to: 'routes#index'
  get '/regenerate', to: 'routes#regenerate'
  get '/login', to: 'routes#login'
end
