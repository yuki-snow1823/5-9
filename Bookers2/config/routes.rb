Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  # git status見ながら正しいURLにくっつけた
  resources :home, only: [:new, :create, :index, :show]
  # 試しにやってみたが違った。ただあとで使うかもしれないから保留。
  resources :users

  resources :books
end
