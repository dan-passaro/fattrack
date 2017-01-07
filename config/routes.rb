Rails.application.routes.draw do
  get 'weight_entries/create'

  resources :weight_entries

  root 'welcome#index'
end
