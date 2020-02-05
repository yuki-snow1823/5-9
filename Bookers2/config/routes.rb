Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  # この上のやつログイン後？後でチェック

  # git status見ながら正しいURLにくっつけた
  resources :home, only: [:new, :create, :show]
  # 試しにやってみたが違った。ただあとで使うかもしれないから保留。
  resources :users

  resources :books

  get 'home/about' => 'home#index', as: 'about'


  # root :to => 'user#index'
end
