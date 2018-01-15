Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  get 'about', to: 'pages#about'
  resources :recipes
  #resources :chefs
end
