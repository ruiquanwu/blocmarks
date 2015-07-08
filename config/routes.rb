Rails.application.routes.draw do

  devise_for :users
  root 'welcome#index'
  post :incoming, to: 'incoming#create'
  resources :topics do
    resources :bookmarks
  end
end
