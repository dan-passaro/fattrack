Rails.application.routes.draw do
  devise_for :users
  get 'weight_entries/create'

  resources :weight_entries

  root 'welcome#index'
end
