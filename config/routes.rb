Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  post :incoming, to: 'incoming#create'
  resources :bookmarks
  resources :topics
end
