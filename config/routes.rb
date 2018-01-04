Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  get 'about', to: 'pages#about'

  get '/recipes', to: 'recipes#index'
  #resources :recipes
  #resources :chefs
end
