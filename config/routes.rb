Rails.application.routes.draw do
  #User Controller
  resources :users, only: [:index, :show]

  #Posts Controller
  resources :posts, only: [:index, :show]

  #Pages Controller
  get 'pages/index'
end
