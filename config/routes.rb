Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stocks', to: 'stocks#search'
  get 'search_friends', to: 'users#search'
  get 'my_friends' , to: 'users#my_friends'
  get 'add_friend' , to: 'users#add_friend'
  resources :user_stocks, only:[:create,:destroy]
  resources :users, only:[:show]
  resources :friendships
end
